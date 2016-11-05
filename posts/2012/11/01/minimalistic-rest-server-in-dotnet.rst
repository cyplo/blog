Install "Microsoft ASP.NET Web API Self Host" and all of its
dependencies via NuGet. 


.. code-block:: csharp

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using System.Web.Http;
    using System.Web.Http.SelfHost;

    namespace resttest
    {
        public class ExampleData { public int Id { get; set; } }

        public class ExampleController : ApiController
        {
            // /api/job
            public IEnumerable<ExampleData> Get()
            {
                return new List<ExampleData>() 
                {
                    new ExampleData(){ Id = 2 },
                    new ExampleData(){ Id = 4 } 
                };
            }

            // /api/job/3
            public ExampleData Get(int id)
            {
                return new ExampleData() { Id = 3 };
            }

        }

        
        class Program
        {
            static void Main(string[] args)
            {
                var configuration = new HttpSelfHostConfiguration("http://localhost:1337");
                //Setup the routes
                configuration.Routes.MapHttpRoute(
                    name: "DefaultApiRoute",
                    routeTemplate: "api/{controller}/{id}",
                    defaults: new
                        { controller = "ExampleController", id = RouteParameter.Optional }
                    );
                var server = new HttpSelfHostServer(configuration);
                server.OpenAsync().Wait();

                Console.Out.WriteLine("Press ESC to quit");
                do
                {
                    while (!Console.KeyAvailable)
                    {
                        Thread.Sleep(256);
                    }
                } while (Console.ReadKey(true).Key != ConsoleKey.Escape);
            }
        }
    }

We can launch it and query it using any http-enabled client: 

``$ curl http://localhost:1337/api/Example [{"Id":2},{"Id":4}]``

C'est volia
