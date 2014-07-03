using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VALE.Logic;
using VALE.Models;

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

        [Test]
        public void should_return_anActivity()
        {
            Activity anActivity = new Activity();
            anActivity.Status = ActivityStatus.Deleted;
            Assert.AreEqual(activityActions.GetStatus(anActivity), "Cancellata");

            anActivity.Status = ActivityStatus.ToBePlanned;
            Assert.AreEqual(activityActions.GetStatus(anActivity), "Da pianificare");

            anActivity.Status = ActivityStatus.Ongoing;
            Assert.AreEqual(activityActions.GetStatus(anActivity), "In corso");
        }

    }
}
