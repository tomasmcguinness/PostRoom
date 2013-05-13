using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Security;
using System.Net.Sockets;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace PostRoom.Management
{
    public class NotificationService
    {
        private const string SERVER = "gateway.sandbox.push.apple.com";

        public void SendiPhonePushNotification(string deviceIdentifier, int numberOfPackages, bool withBody)
        {
            SslStream sslStream = null;

            TcpClient tcpClient = new TcpClient(SERVER, 2195);

            sslStream = new SslStream(tcpClient.GetStream());

            try
            {
                X509Certificate2Collection certs = new X509Certificate2Collection();

                certs.Add(GetPushServerCert());

                sslStream.AuthenticateAsClient(SERVER, certs, SslProtocols.Default, false);
            }
            catch (AuthenticationException)
            {
                tcpClient.Close();
                return;
            }

            byte[] buf = new byte[256];
            MemoryStream ms = new MemoryStream();
            BinaryWriter bw = new BinaryWriter(ms);
            bw.Write(new byte[] { 0, 0, 32 });

            byte[] deviceToken = HexToData(deviceIdentifier);
            bw.Write(deviceToken);

            bw.Write((byte)0);

            string msg = null;

            if (withBody)
            {
                msg = string.Format("{{\"aps\":{{\"alert\":\"You have {0} package(s) for collection\",\"badge\":{0},\"sound\":\"default\"}}, \"packageCount\":{0}}}", numberOfPackages);
            }
            else
            {
                msg = string.Format("{{\"aps\":{{\"badge\":{0}}}, \"packageCount\":{0}}}", numberOfPackages);
            }

            Debug.WriteLine(msg);

            // Write the data out to the stream
            //
            bw.Write((byte)msg.Length);
            bw.Write(msg.ToCharArray());
            bw.Flush();

            if (sslStream != null)
            {
                sslStream.Write(ms.ToArray());
            }

            sslStream.Flush();
            sslStream.Close();
        }

        private static X509Certificate GetPushServerCert()
        {
            string path = HttpContext.Current.Server.MapPath("~/Certificates/PostRoom Dev APNS.pfx");

            X509Certificate2 cert = new X509Certificate2(path, "Bjaxebh2");

            return cert;
        }

        private static byte[] HexToData(string hexString)
        {
            if (hexString == null)
                return null;

            if (hexString.Length % 2 == 1)
                hexString = '0' + hexString; // Up to you whether to pad the first or last byte

            byte[] data = new byte[hexString.Length / 2];

            for (int i = 0; i < data.Length; i++)
                data[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);

            return data;
        }
    }
}
