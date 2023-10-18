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

                string sasToken = "sv=2021-10-04&ss=f&srt=co&se=2023-10-25T05%3A04%3A50Z&sp=rl&sig=5RepzlEp%2BvyTTKNQMhKmIeGLYbU2FJSryHLCf5B27OY%3D";

                string blobUrlWithSAS = "https://cs410032001eacab1d7.file.core.windows.net/cs-rdiaz55-uisad-uis-edu-10032001eacab1d7/voices" + sasToken;

                using (var httpClient = new HttpClient())
                {
                    try
                    {
                        // Open a stream to read the file's content.
                        using (var stream = file.OpenReadStream())
                        {
                            // Create a content to send the file content.
                            var content = new StreamContent(stream);

                            // Set the content type (e.g., audio/wav).
                            content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("audio/wav");

                            // Send a PUT request to upload the file to Azure Blob Storage.
                            var response = await httpClient.PutAsync(new Uri(blobUrlWithSAS), content);

                            if (response.IsSuccessStatusCode)
                            {
                                return Request.CreateResponse(HttpStatusCode.OK, "Voice file has been received:" + blobUrlWithSAS);
                            }
                            else
                            {
                                // Handle the case when the upload was not successful.
                                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad file upload");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions, e.g., if the file doesn't exist.
                        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error with upload:" + "" + ex.Message);
                    }
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
