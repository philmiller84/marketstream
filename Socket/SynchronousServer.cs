using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace SynchronousSocket
{
    public class Server
    {
        public static string data = null;
        public Socket listener;
        public Socket handler;

        public Server()
        {
            // Dns.GetHostName returns the name of the
            // host running the application.
            IPHostEntry ipHostInfo = Dns.GetHostEntry(Dns.GetHostName());
            IPAddress ipAddress = IPAddress.Parse("127.0.0.1");
            //IPAddress ipAddress = ipHostInfo.AddressList[0];
            IPEndPoint localEndPoint = new IPEndPoint(ipAddress, 65433);

            // Create a TCP/IP socket.
            listener = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);

            // Bind the socket to the local endpoint and
            // listen for incoming connections.
            try
            {
                listener.Bind(localEndPoint);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                Environment.Exit(1);
            }
        }

        ~Server()
        {
            handler.Shutdown(SocketShutdown.Both);
            handler.Close();
        }

        public void WaitForConnect()
        {
            // listen for incoming connections.
            try
            {
                listener.Listen(10);

                // Start listening for connections.
                while (true)
                {
                    Console.WriteLine("Waiting for a connection...");
                    // Program is suspended while waiting for an incoming connection
                    handler = listener.Accept();
                    data = null;

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        public void HandleRequest()
        {
            // Data buffer for incoming data
            var bytes = new byte[1024];

            try
            {
                //    // And incoming connection needs to be processed.
                //    while (true)
                //    {
                //        int bytesRec = handler.Receive(bytes);
                //        data += Encoding.ASCII.GetString(bytes, 0, bytesRec);
                //        if (data.IndexOf("<EOF>") > -1)
                //        {
                //            break;
                //        }
                //    }
                //    // Show the data on the console.
                //    Console.WriteLine("Text received : {0}", data);

                // Echo the data back to the client.
                byte[] msg = Encoding.ASCII.GetBytes(data);

                handler.Send(msg);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }

            Console.WriteLine("\nPress ENTER to continue...");
            Console.Read();
        }
    }
}
