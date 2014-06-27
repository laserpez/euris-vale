using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    interface IActions
    {
        List<T> GetSortedData<T>(string sortExpression, SortDirection direction, List<T> data);
        List<T> GetFilteredData<T>(Dictionary<string, string> filters, List<T>data);
        bool AddOrRemoveUserData<T>(T data, UserData user);
        
        bool AddAttachment(int attachmentId);
        bool RemoveAttachment(int attachmentId);
    }
}
