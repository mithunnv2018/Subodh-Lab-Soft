
/**
 * MyLoginCallbackHandler.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.6.1  Built on : Aug 31, 2011 (12:22:40 CEST)
 */

    package com.caddybook.app;

    /**
     *  MyLoginCallbackHandler Callback class, Users can extend this class and implement
     *  their own receiveResult and receiveError methods.
     */
    public abstract class MyLoginCallbackHandler{



    protected Object clientData;

    /**
    * User can pass in any object that needs to be accessed once the NonBlocking
    * Web service call is finished and appropriate method of this CallBack is called.
    * @param clientData Object mechanism by which the user can pass in user data
    * that will be avilable at the time this callback is called.
    */
    public MyLoginCallbackHandler(Object clientData){
        this.clientData = clientData;
    }

    /**
    * Please use this constructor if you don't want to set any clientData
    */
    public MyLoginCallbackHandler(){
        this.clientData = null;
    }

    /**
     * Get the client data
     */

     public Object getClientData() {
        return clientData;
     }

        
           /**
            * auto generated Axis2 call back method for doRegisterCaddy method
            * override this method for handling normal response from doRegisterCaddy operation
            */
           public void receiveResultdoRegisterCaddy(
                    com.caddybook.app.MyLoginStub.DoRegisterCaddyResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from doRegisterCaddy operation
           */
            public void receiveErrordoRegisterCaddy(java.lang.Exception e) {
            }
                
           /**
            * auto generated Axis2 call back method for doLoginCaddy method
            * override this method for handling normal response from doLoginCaddy operation
            */
           public void receiveResultdoLoginCaddy(
                    com.caddybook.app.MyLoginStub.DoLoginCaddyResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from doLoginCaddy operation
           */
            public void receiveErrordoLoginCaddy(java.lang.Exception e) {
            }
                


    }
    