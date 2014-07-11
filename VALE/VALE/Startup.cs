using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(VALE.Startup))]
namespace VALE
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
