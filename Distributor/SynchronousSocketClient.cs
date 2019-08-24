using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Net;
using System.Net.Sockets;

namespace Distributor
{
    public class SynchronousSocketClient
    {
        public SynchronousSocketClient()
        {
            StartClient();
        }
        ~SynchronousSocketClient()
        {
            Shutdown();
        }

        public bool MakeConnection(IPEndPoint remoteEP)
        {
            try
            {
                sender.Connect(remoteEP);
                Console.WriteLine("Socket connected to {0}", sender.RemoteEndPoint.ToString());
            }
            catch (SocketException e)
            {
                if (e.SocketErrorCode == SocketError.ConnectionRefused)
                {
                    int sleepInt = 10000;
                    Console.WriteLine(e.ToString());
                    Console.WriteLine("Sleeping {0} milliseconds", sleepInt);
                    Thread.Sleep(sleepInt);
                }
                return false;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return false;
            }
            return true;
        }

        public void StartClient()
        {
            IPHostEntry ipHostInfo = Dns.GetHostEntry(Dns.GetHostName());
            IPAddress ipAddress = IPAddress.Parse("127.0.0.1");
            IPEndPoint remoteEP = new IPEndPoint(ipAddress, 65432);

            sender = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);

            int tries = 0;
            int MAX_TRIES = 10;

            while(!MakeConnection(remoteEP))
            {
                tries++;
                if (tries >= MAX_TRIES)
                {
                    Console.WriteLine("No connection made -- exiting()");
                    System.Environment.Exit(0);
                }                
                Console.WriteLine("Failed to connect, will retry");
                Console.WriteLine("+++++++++++++++++++++++++++++++");
            }
        }

        public void Shutdown()
        {
            try
            {
                sender.Shutdown(SocketShutdown.Both);
                sender.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("Exception {0}", e.ToString());
            }
        }

        public string Request(string commandStr)
        {
            try
            {
                byte[] msg = Encoding.ASCII.GetBytes(commandStr);
                int bytesSent = sender.Send(msg);

                byte[] bytes = new byte[1024];
                int bytesRec = sender.Receive(bytes);
                string recvStr = Encoding.ASCII.GetString(bytes, 0, bytesRec);
                //Console.WriteLine("Received: {0}", recvStr);
                return recvStr;
            }
            catch (SocketException e)
            {
                if (e.SocketErrorCode == SocketError.ConnectionRefused)
                {
                    int sleepInt = 10000;
                    Console.WriteLine(e.ToString());
                    Console.WriteLine("Sleeping {0} milliseconds", sleepInt);
                    Thread.Sleep(sleepInt);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            return null;
        }

        public Socket sender;
    }
}