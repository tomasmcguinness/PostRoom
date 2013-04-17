using PostRoom.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
  public class ResidentManager
  {
    private PostRoomDataContext context;

    public ResidentManager()
    {
        context = new PostRoomDataContext();
    }

    public void AddResident(long apartmentId, string deviceIdentifier)
    {
        Resident newResident = new Resident()
        {
            ApartmentId = apartmentId,
            DeviceIdentifier = deviceIdentifier
        };

        context.Residents.Add(newResident);
    }
  }
}
