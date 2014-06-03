using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class BlogArticle
    {
        public int BlogArticleId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public DateTime ReleaseDate { get; set; }

        [ForeignKey("Creator")]
        public string CreatorId { get; set; }
        public virtual UserData Creator { get; set; }

        public string Status { get; set; }

        public virtual List<BlogComment> Comments { get; set; }
    }
}