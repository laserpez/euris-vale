using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VALE.Models;

namespace VALE.Logic
{
    public interface IFileActions
    {
        bool AddAttachment(int dataId, AttachedFile file);
        bool RemoveAttachment(int attachmentId);
        List<AttachedFile> GetAttachments(int dataId);
        bool RemoveAllAttachments(int dataId);
    }
}
