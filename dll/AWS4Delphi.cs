using System;
using System.Runtime.InteropServices;
using AWS4Delphi.SMS;
using AWS4Delphi.S3;
using AWS4Delphi.Email;
using RGiesecke.DllExport;

namespace AWS4Delphi
{
    [Guid("64D83480-BE6B-4D90-98F4-2A6431646FFA")]
    [ComVisible(true)]
    public class AWS4Delphi
    {
        [DllExport]
        public static string SendSMS(string aJSONParameters)
        {            
            try
            {
                return ServiceSMS.SendSMS(aJSONParameters);                
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }      
        
        [DllExport]
        public static string SendFile(string aJSONParameters)
        {
            try
            {
                return ServiceS3.SendFile(aJSONParameters);
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        [DllExport]
        public static string SendFileMP(string aJSONParameters)
        {
            try
            {
                return ServiceS3.SendFileMP(aJSONParameters);
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        [DllExport]
        public static string SendEmail(string aJSONParameters)
        {            
            try
            {
                return ServiceEmail.SendEmail(aJSONParameters);
            }
            catch (Exception e)
            {
                return e.Message;
            }

        }

        [DllExport]
        public static string SendEmailWithFile(string aJSONParameters)
        {
            try
            {
                return ServiceEmail.SendEmailWithFile(aJSONParameters);
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
    }
}
