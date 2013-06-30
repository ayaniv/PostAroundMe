<%@ WebHandler Language="C#" Class="FileUpload" %>

using System;
using System.Web;
using System.IO;
using System.Drawing;
using System.Linq;

public class FileUpload : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        string result = "";
        try
        {
            int userId = Tools.GetUserIdFromCookie(context);
            if (userId < 0)
                throw new Exception("User not Login");
            
            String filename;
            string fileExtension;
            string guid = Guid.NewGuid().ToString().Replace("-", "");
        
            System.Drawing.Imaging.ImageFormat format;
            Image img = null;
            Image imgBig = null;
        
            string mapPath = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\Uploaded";
            string mapPathResized = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\UploadedResized";
            string mapPathResizedBig = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\UploadedResizedBig";

            if (HttpContext.Current.Request.Browser.Browser.ToLower().Equals("ie") && (HttpContext.Current.Request.Browser.MajorVersion < 10))
            {
                HttpPostedFile uploadedfile = context.Request.Files[0];
                filename = uploadedfile.FileName;

                fileExtension = Path.GetExtension(filename);
                format = StringToFormat(fileExtension);
                if (format != null)
                {
                    filename = guid + fileExtension;
                    uploadedfile.SaveAs(mapPath + "\\" + filename);
                    img = ResizeImage(Image.FromStream(uploadedfile.InputStream), 235, 0);
                    imgBig = ResizeImage(Image.FromStream(uploadedfile.InputStream), 610, 0);
                }

            }
            else
            {
                filename = HttpContext.Current.Request.Headers["X-File-Name"];
                fileExtension = Path.GetExtension(filename);
                format = StringToFormat(fileExtension);
                if (format != null)
                {
                    filename = guid + fileExtension;
                    //This works for Firefox and Chrome.
                    Stream inputStream = HttpContext.Current.Request.InputStream;
                    FileStream fileStream = new FileStream(mapPath + "\\" + filename, FileMode.CreateNew);
                    inputStream.CopyTo(fileStream);
                    fileStream.Close();

                    img = ResizeImage(Image.FromStream(inputStream), 243, 0);
                    imgBig = ResizeImage(Image.FromStream(inputStream), 610, 0);
                }

            }

            if (format != null && img != null)
            {
                SaveAsJpeg(imgBig, mapPathResizedBig + "\\" + filename, 80, format);
                SaveAsJpeg(img, mapPathResized + "\\" + filename, 80, format);
                result = "{success:true, name:\"" + filename + "\", path:\"" + mapPath + "/" + filename + "\"}";
            }
            else
            {
                result = "{success:false}";
            }
        }
        catch (Exception ex)
        {
            result = "{success:false}";
        }
        

        context.Response.Write(result);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    private static Image resizeImage(Image imgToResize, Size size)
    {
        int sourceWidth = imgToResize.Width;
        int sourceHeight = imgToResize.Height;

        float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;

        nPercentW = ((float)size.Width / (float)sourceWidth);
        nPercentH = ((float)size.Height / (float)sourceHeight);

        if (nPercentH < nPercentW)
            nPercent = nPercentH;
        else
            nPercent = nPercentW;

        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        Bitmap b = new Bitmap(destWidth, destHeight);
        Graphics g = Graphics.FromImage((Image)b);
        g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;

        g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
        g.Dispose();

        return (Image)b;
    }

    private static System.Drawing.Imaging.ImageFormat StringToFormat(string fileExtension)
    {
        string extension = fileExtension.ToLower();
        System.Drawing.Imaging.ImageFormat format = null;

        if (extension == ".jpeg" || extension == ".jpg")
                format = System.Drawing.Imaging.ImageFormat.Jpeg;
            else if (extension == ".gif")
                format  =System.Drawing.Imaging.ImageFormat.Gif;
            else if (extension == ".png")
                format  = System.Drawing.Imaging.ImageFormat.Png;

        return format;
    }

    public static byte[] ImageToByte(Image img)
    {
        ImageConverter converter = new ImageConverter();
        return (byte[])converter.ConvertTo(img, typeof(byte[]));
    }

    public static System.Drawing.Bitmap ResizeImage(System.Drawing.Image image, int width, int height)
    {

        float imagePrpotions = (float)image.Height / (float)image.Width;
        int propHeight = Convert.ToInt32(Math.Floor(width * imagePrpotions));

        //int propWidth = width;
        
        // for just resize, with no proposion use this line
        //propHeight = height;
        //if (isBig)
        //{
        //    if (image.Height > image.Width)
        //    {
        //        propHeight = width;
        //        propWidth = height;
        //    }
        //    else
        //    {
        //        propHeight = height;
        //        propWidth = width;
        //    }
            
        //}
        
            
        
        //a holder for the result
        Bitmap result = new Bitmap(width, propHeight);

        //use a graphics object to draw the resized image into the bitmap
        using (Graphics graphics = Graphics.FromImage(result))
        {
            //set the resize quality modes to high quality
            graphics.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighSpeed;
            graphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.Low; //.Default; //.HighQualityBicubic;
            graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.None; //.Invalid; //.HighSpeed; //.HighQuality;
            //draw the image into the target bitmap
            graphics.DrawImage(image, 0, 0, result.Width, result.Height);
        }

        //return the resulting bitmap
        return result;
    }


    static private System.Drawing.Imaging.ImageCodecInfo GetEncoder(System.Drawing.Imaging.ImageFormat format)
    {
        return System.Drawing.Imaging.ImageCodecInfo.GetImageDecoders().SingleOrDefault(c => c.FormatID == format.Guid);
    }

    public static void SaveAsJpeg(Image Img, string FileName, Int64 Quality, System.Drawing.Imaging.ImageFormat format)
    {
        System.Drawing.Imaging.ImageCodecInfo encoder = GetEncoder(format);
        System.Drawing.Imaging.Encoder QualityEncoder = System.Drawing.Imaging.Encoder.Quality;

        using (System.Drawing.Imaging.EncoderParameters EP = new System.Drawing.Imaging.EncoderParameters(3))
        {

            EP.Param[0] = new System.Drawing.Imaging.EncoderParameter(QualityEncoder, Quality);
            EP.Param[1] = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)System.Drawing.Imaging.EncoderValue.ScanMethodInterlaced);
            EP.Param[2] = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)System.Drawing.Imaging.EncoderValue.RenderProgressive);

            Img.Save(FileName, encoder, EP);
            
        }
    }









}