var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/scan/{ipRede}/{range}", async context =>
{
    var ipRede = context.Request.RouteValues["ipRede"];
    var Range = context.Request.RouteValues["range"];
    //var portaInicio = context.Request.RouteValues["inicio"];
    //var portaFim = context.Request.RouteValues["fim"];

    System.Diagnostics.ProcessStartInfo process = new System.Diagnostics.ProcessStartInfo();
    process.UseShellExecute = false;
    process.WorkingDirectory = "/bin";
    process.FileName = "bash";
    process.Arguments = $"SEU DIRETORIO + SCRIPT {ipRede} {Range}";
    process.RedirectStandardOutput = true;

    using (System.Diagnostics.Process cmd = System.Diagnostics.Process.Start(process))
    {
        cmd.WaitForExit();
    }

    string logContent = await System.IO.File.ReadAllTextAsync("SEU DIRETORIO/log.txt/log.txt");

    context.Response.ContentType = "text/plain"; 
    await context.Response.WriteAsync($"IP da rede: {ipRede} a {Range}.\n");
    await context.Response.WriteAsync(logContent);
});

app.Run();


//Adicionar uma saida de erro para ADM