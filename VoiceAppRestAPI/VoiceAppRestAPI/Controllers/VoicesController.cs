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
//using Microsoft.AspNetCore.Mvc;

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
        public async Task<HttpResponseMessage> UploadVoiceFileBuffer(IFormFile file)
        {
            try
            {

                if (file != null)
                {
                    if (!file.ContentType.Equals("audio/wav", StringComparison.OrdinalIgnoreCase))
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.UnsupportedMediaType, "Unsupported Media Type");

                    }
               

                    string sasToken = "sv=2021-10-04&ss=f&srt=co&se=2023-10-25T05%3A04%3A50Z&sp=rl&sig=5RepzlEp%2BvyTTKNQMhKmIeGLYbU2FJSryHLCf5B27OY%3D";

                    string blobUrlWithSAS = "https://cs410032001eacab1d7.file.core.windows.net/cs-rdiaz55-uisad-uis-edu-10032001eacab1d7/voices" + sasToken;
                    string storageConnectionString = "DefaultEndpointsProtocol=https;AccountName=cs410032001eacab1d7;AccountKey=BGSQ3qn21WeD0mzUGCwZxA5mTbSHA+2Nyx+gCU8YY3p2kJtmuqytIhhHBRljt1NPKjmPynOlR32y+AStLcWPRQ==;EndpointSuffix=core.windows.net";
                    
                    string containerName = "cs-rdiaz55-uisad-uis-edu-10032001eacab1d7";

                    var blobName = $"{Guid.NewGuid()}-{file.FileName}";

                    BlobServiceClient blobServiceClient = new BlobServiceClient(storageConnectionString);
                    BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient(containerName);
                    BlobClient blobClient = containerClient.GetBlobClient(blobName);

                    using (Stream stream = file.OpenReadStream())
                    {
                        await blobClient.UploadAsync(stream, true);
                        var data = new { message = "Hello mate" };
                        return Request.CreateResponse(HttpStatusCode.OK, new StringContent(JsonConvert.SerializeObject(data), Encoding.UTF8, "application/json"));
                    }

                    /*
                    var voiceFile = HttpContext.Current.Request.Files[0];
                    if ((voiceFile == null) || (voiceFile.ContentLength == 0))
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Voice file could not be uploaded.");
                    }
                    var voiceUploadFolder = AppDomain.CurrentDomain.BaseDirectory + "\\" + "UploadVoice";
                    Console.WriteLine("Voice upload folder was:" + voiceUploadFolder);
                    Directory.CreateDirectory(voiceUploadFolder);

                    var voiceFileName = $"{voiceFile.FileName}_{Guid.NewGuid()}";
                    var longFile = voiceUploadFolder + "\\" + voiceFileName;
                    Console.WriteLine("Voice filename was:" + longFile);
                    voiceFile.SaveAs(longFile);
                    return Request.CreateResponse(HttpStatusCode.OK, "Voice file has been received:" + longFile.ToString()); */
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Null file");
                }
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error with upload:" + "" + e.Message);
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
