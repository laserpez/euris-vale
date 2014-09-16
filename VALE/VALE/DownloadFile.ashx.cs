﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using VALE.Models;

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
            int fileId = Convert.ToInt16(request.QueryString["fileId"]);
            string page = request.QueryString["page"];

            if (page == "VALEDocuments")
            {
                ValeFile(fileId);
            }
            else if (page == "Profile") 
            {
                UserFile(fileId);
            }
            else
            {
                AttachedFile(fileId);
            }

            
        }

        private void AttachedFile(int fileId)
        {
            using (var _db = new UserOperationsContext())
            {
                var file = _db.AttachedFiles.FirstOrDefault(f => f.AttachedFileID == fileId);
                if (file != null)
                {
                    HttpResponse response = HttpContext.Current.Response;
                    response.ClearContent();
                    response.Clear();
                    response.ContentType = "application/octet-stream";
                    response.AddHeader("Content-Disposition", "attachment; filename=" + file.FileName + ";");
                    response.BinaryWrite(file.FileData);
                    response.Flush();
                    response.End();
                }
            }
        }

        private void ValeFile(int fileId)
        {
            using (var _db = new UserOperationsContext())
            {
                var file = _db.VALEFiles.FirstOrDefault(f => f.ValeFileID == fileId);
                if (file != null)
                {
                    HttpResponse response = HttpContext.Current.Response;
                    response.ClearContent();
                    response.Clear();
                    response.ContentType = "application/octet-stream";
                    response.AddHeader("Content-Disposition", "attachment; filename=" + file.FileName + ";");
                    response.BinaryWrite(file.FileData);
                    response.Flush();
                    response.End();
                }
            }
        }

        private void UserFile(int fileId)
        {
            using (var _db = new UserOperationsContext())
            {
                var file = _db.UserFiles.FirstOrDefault(f => f.UserFileID == fileId);
                if (file != null)
                {
                    HttpResponse response = HttpContext.Current.Response;
                    response.ClearContent();
                    response.Clear();
                    response.ContentType = "application/octet-stream";
                    response.AddHeader("Content-Disposition", "attachment; filename=" + file.FileName + ";");
                    response.BinaryWrite(file.FileData);
                    response.Flush();
                    response.End();
                }
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