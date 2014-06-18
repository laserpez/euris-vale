using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace VALE
{
    /// <summary>
    /// Summary description for DownloadFile
    /// </summary>
    public class DownloadFile : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            HttpRequest request = HttpContext.Current.Request;
            string serverPath = HttpContext.Current.Server.MapPath(request.QueryString["filePath"]);
            string fileName = request.QueryString["fileName"];
            if (File.Exists(serverPath))
            {
                HttpResponse response = HttpContext.Current.Response;
                response.ClearContent();
                response.Clear();
                response.ContentType = "application/octet-stream";
                response.AddHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
                response.TransmitFile(serverPath);
                response.Flush();
                response.End();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}