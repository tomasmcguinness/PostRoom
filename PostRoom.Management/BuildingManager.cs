using PostRoom.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
  public class BuildingManager
  {
    private PostRoomDataContext context;

    public BuildingManager()
    {
      context = new PostRoomDataContext();
    }

    public List<Building> GetBuildingsForEstate(int userId, long estateId)
    {
      return context.Estates.Find(estateId).Buildings.ToList();
    }
  }
}
