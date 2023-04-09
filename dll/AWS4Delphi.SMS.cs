using Amazon;
using Amazon.Pinpoint;
using Amazon.Pinpoint.Model;
using Amazon.Runtime;
using AWS4Delphi.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace AWS4Delphi.SMS
{
    class ServiceSMS
    {
        public static string SendSMS(string aJSONParameters)
        {
            string xReturn = "";

            try
            {
                //Environment Variables
                string xAccessToken = Environment.GetEnvironmentVariable("TOKEN_AWS", EnvironmentVariableTarget.User);
                string xSecretToken = Environment.GetEnvironmentVariable("SECRET_AWS", EnvironmentVariableTarget.User);

                InputParametersPinpoint inputParametersPinpoint = JsonConvert.DeserializeObject<InputParametersPinpoint>(aJSONParameters);

                //Creating objects to comunication
                DadosPinpoint dadosPinpoint = new DadosPinpoint();
                dadosPinpoint.credentials = new BasicAWSCredentials(xAccessToken, xSecretToken);
                dadosPinpoint.client = new AmazonPinpointClient(dadosPinpoint.credentials, RegionEndpoint.GetBySystemName(inputParametersPinpoint.RegionAWS));
                dadosPinpoint.request = new SendMessagesRequest();

                //Parameters request
                dadosPinpoint.request.ApplicationId = inputParametersPinpoint.AppID;
                dadosPinpoint.request.MessageRequest = new MessageRequest();
                dadosPinpoint.request.MessageRequest.Addresses = new Dictionary<string, AddressConfiguration>();

                AddressConfiguration addressConfiguration = new AddressConfiguration();
                addressConfiguration.ChannelType = "SMS";

                //Parameters message
                DirectMessageConfiguration messageConfiguration = new DirectMessageConfiguration();
                messageConfiguration.SMSMessage = new SMSMessage();
                messageConfiguration.SMSMessage.Body = inputParametersPinpoint.MessageBody;
                messageConfiguration.SMSMessage.MessageType = "TRANSACTIONAL";

                foreach (string destination in inputParametersPinpoint.RecipientList)
                {
                    dadosPinpoint.request.MessageRequest.Addresses.Add(destination, addressConfiguration);
                }                

                dadosPinpoint.request.MessageRequest.MessageConfiguration = messageConfiguration;

                //Sending message                
                dadosPinpoint.response = dadosPinpoint.client.SendMessages(dadosPinpoint.request);
                xReturn = dadosPinpoint.response.HttpStatusCode.ToString();

                return xReturn;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
    }
}
