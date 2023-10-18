using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using System.Threading.Tasks;
using System.Web;

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
        public async Task<HttpResponseMessage> UploadVoiceFileBuffer()
        {
            try
            {
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
                return Request.CreateResponse(HttpStatusCode.OK, "Voice file has been received:" + longFile.ToString());
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
