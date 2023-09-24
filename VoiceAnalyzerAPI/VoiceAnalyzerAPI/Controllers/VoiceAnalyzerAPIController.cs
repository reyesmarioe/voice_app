using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace VoiceAnalyzerAPI.Controllers
{
    public class VoiceAnalyzerAPIController : ApiController
    {
        // GET: api/VoiceAnalyzerAPI
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/VoiceAnalyzerAPI/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/VoiceAnalyzerAPI
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/VoiceAnalyzerAPI/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/VoiceAnalyzerAPI/5
        public void Delete(int id)
        {
        }
    }
}
