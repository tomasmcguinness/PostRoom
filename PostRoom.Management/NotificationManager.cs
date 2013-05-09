using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
    public class NotificationManager
    {
        private ResidentManager residentManager;
        private NotificationService notificationService;

        public NotificationManager()
        {
            residentManager = new ResidentManager();
            notificationService = new NotificationService();
        }

        public void NotifyDeliveryToApartment(long apartmentId, int totalPackages)
        {
            var residents = residentManager.GetResidentsForApartment(apartmentId);
            

            foreach (var resident in residents)
            {
                notificationService.SendiPhonePushNotification(resident.UniqueIdentifier, totalPackages);
            }
        }
    }
}
