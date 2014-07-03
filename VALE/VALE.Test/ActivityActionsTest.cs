using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VALE.Logic;

namespace VALE.Test
{
    [TestFixture]
    class ActivityActionsTest
    {
        private ActivityActions activityActions;

        [SetUp]
        public void SetUp()
        {
            activityActions = new ActivityActions();
        }

        [TearDown]
        public void TearDown()
        {
           
        }

    }
}
