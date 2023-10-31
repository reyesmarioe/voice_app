using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System.Text;
using Azure.Storage.Blobs;
using Microsoft.Azure.Storage;
using Microsoft.Azure.Storage.Blob;
//using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace VoiceAppRestAPI.Controllers
{
    public class VoicesController : ApiController
    {
        // GET api/values
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        [HttpPost]
        [Route("api/uploadvoice")]
        public async Task<IHttpActionResult> UploadVoiceFileBuffer() 
        { 
            try
            {
                if (!Request.Content.IsMimeMultipartContent())
                {
                    return BadRequest("The request is not a valid multipart/form-data request");
                }

                string outputStr = "";

                var provider = new MultipartFormDataStreamProvider(Path.GetTempPath());
                await Request.Content.ReadAsMultipartAsync(provider);

                foreach (var fileData in provider.FileData) {

                    var headers = fileData.Headers;

                    string originalFileName = headers.ContentDisposition.FileName.Trim('\"');

                    if (string.IsNullOrEmpty(originalFileName))
                    {
                        continue; // skip if filename not available
                    }
                    var file = new FileInfo(fileData.LocalFileName);

                    string sasToken = "sv=2021-10-04&ss=f&srt=co&se=2023-10-25T05%3A04%3A50Z&sp=rl&sig=5RepzlEp%2BvyTTKNQMhKmIeGLYbU2FJSryHLCf5B27OY%3D";

                    string blobUrlWithSAS = "https://cs410032001eacab1d7.file.core.windows.net/cs-rdiaz55-uisad-uis-edu-10032001eacab1d7/voices" + sasToken;
                    string storageConnectionString = "DefaultEndpointsProtocol=https;AccountName=cs410032001eacab1d7;AccountKey=BGSQ3qn21WeD0mzUGCwZxA5mTbSHA+2Nyx+gCU8YY3p2kJtmuqytIhhHBRljt1NPKjmPynOlR32y+AStLcWPRQ==;EndpointSuffix=core.windows.net";

                    string containerName = "testcontainer"; // "cs-rdiaz55-uisad-uis-edu-10032001eacab1d7";

                    var blobName = $"{Guid.NewGuid()}-{originalFileName}";

                    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConnectionString);
                    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
                    CloudBlobContainer container = blobClient.GetContainerReference(containerName);
                    CloudBlockBlob blob = container.GetBlockBlobReference(blobName);


                    using (var fileStream = File.OpenRead(fileData.LocalFileName)) // Request.Content.ReadAsStreamAsync().Result
                    {
                        await blob.UploadFromStreamAsync(fileStream);

                    }

                    // call python script against the file
                    string pythonScript = "callStt.py";
                    ProcessStartInfo startInfo = new ProcessStartInfo
                    {
                        FileName = "python",
                        Arguments = $"{pythonScript} {blobName}",
                        RedirectStandardOutput = true,
                        RedirectStandardError = true,
                        UseShellExecute = false,
                        CreateNoWindow = true
                    };

                    using (Process process = new Process())
                    {
                        process.StartInfo = startInfo;

                        process.OutputDataReceived += (sender, e) =>
                        {
                            if (!string.IsNullOrEmpty(e.Data))
                            {
                                // Handle the output from your Python script
                                Console.WriteLine(e.Data);
                            }
                        };

                        process.ErrorDataReceived += (sender, e) =>
                        {
                            if (!string.IsNullOrEmpty(e.Data))
                            {
                                // Handle any errors from your Python script
                                Console.WriteLine("Error: " + e.Data);
                                outputStr += ("Error: " + e.Data);
                            }
                        };

                        process.Start();
                        process.BeginOutputReadLine();
                        process.BeginErrorReadLine();
                        process.WaitForExit();

                        // Check the exit code to see if the script was successful
                        int exitCode = process.ExitCode;
                        if (exitCode == 0)
                        {
                            Console.WriteLine("Python script executed successfully.");
                        }
                        else
                        {
                            Console.WriteLine($"Python script failed with exit code {exitCode}");
                        }
                    }
                }

                return Ok("File uploaded and analysis run successfully:" + outputStr);
                
            }
            catch (Exception e)
            {
                return InternalServerError(e); //Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error with upload:" + "" + e.Message);
            }

        }

        // PUT api/values/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}
