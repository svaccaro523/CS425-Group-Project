import java.util.*;
import java.sql.*;
import java.math.*;

public class Grocery
{
	public static void main(String[]args)
	{
        try
        {
            //Connect to Database
            System.out.println("Attempting to find Driver!");
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Attempting to connect to FOURIER!");
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@fourier.cs.iit.edu:1521:univdb:svaccaro:TechGirl523:)");
            System.out.println("I am connected to FOURIER!");
        
            Scanner u=new Scanner(System.in);
            Scanner p=new Scanner(System.in);
            
            int accessed=0;
            while(accessed==0)
            {
                //Enter Username and Password
                //System.out.println("Welcome! Are you a returning customer or employee?");
                
                System.out.print("Username:");
                String user=u.nextLine();
                System.out.println(" ");
                
                System.out.print("Password:");
                String password=p.nextLine();
                System.out.println(" ");
             
                if(user.equals("Employee1")&password.equals("Worker1"))
                {
                    accessed=1;
                    System.out.println("Welcome "+user+": ");
                    int Echoice = Integer.parseInt(Eopts());
                    while(Echoice!= 4)
                    {
                        switch(Echoice)
                        {
                            case 1:
                            {
                                //Profile Method
                                eProfile(user);
                                Echoice = Integer.parseInt(Eopts());
                                break;
                            }
                            case 2:
                            {
                                //Inventory Method
                                System.out.println("Inventory Method");
                                System.out.println(" ");
                                Echoice = Integer.parseInt(Eopts());
                                break;
                            }
                            case 3:
                            {
                                //Orders Method
                                System.out.println("Orders Method");
                                System.out.println(" ");
                                Echoice = Integer.parseInt(Eopts());
                                break;
                            }
                            default:
                            {
                                System.out.println("Option Not Recognized.");
                                Echoice = Integer.parseInt(Eopts());
                                break;
                            } 
                        }
                    }
                }
                else if(user.equals("Customer1")&password.equals("Password"))
                {
                    accessed=1;
                    System.out.println("Welcome "+user+": ");
                    int C_choice = Integer.parseInt(Copts());
                    while(C_choice!=5)
                    {
                        switch (C_choice)
                        {
                            case 1:
                            {
                                //Profile Method
                                cProfile(user);
                                C_choice = Integer.parseInt(Copts());
                                break;
                            }
                            case 2:
                            {
                                //Catelog Method
                                System.out.println("Catelog Method");
                                System.out.println(" ");
                                C_choice = Integer.parseInt(Copts());
                                break;
                            }
                            case 3:
                            {
                                //My Cart Method
                                System.out.println("My Cart Method");
                                System.out.println(" ");
                                C_choice = Integer.parseInt(Copts());
                                break;
                            }
                            case 4:
                            {
                                //Order Status Method
                                System.out.println("Order Status");
                                System.out.println(" ");
                                C_choice = Integer.parseInt(Copts());
                                break;
                            }
                            default:
                            {
                                System.out.println("Option Not Recognized.");
                                C_choice = Integer.parseInt(Copts());
                                break;
                            }
                        }
                    }
                }
                else
                {
                    System.out.println("Incorrect Username or Password");
                }
            }
        }
        catch (SQLException sqle)
        {
            System.out.println("SQLException: "+sqle);
            System.exit(1);
        }
        catch (ClassNotFoundException cnf)
        {
            System.out.println("Error: "+cnf);
            System.exit(1);
        }
	}
    
    public static String Eopts()
    {
        System.out.println("Please select from the following options by entering the number next to it: ");
        System.out.println("1.Profile");
        System.out.println("2.Inventory");
        System.out.println("3.Orders");
        System.out.println("4.Log Off");
        System.out.print(": ");
        Scanner optE = new Scanner(System.in);
        String chooseE = optE.nextLine();
        System.out.println(" ");
        return chooseE;
    }
    
    public static String Copts()
    {
        System.out.println("Please select from the following options by entering the number next to it: ");
        System.out.println("1.Profile");
        System.out.println("2.Catelog");
        System.out.println("3.My Cart");
        System.out.println("4.Order Status");
        System.out.println("5.Log Off");
        System.out.print(": ");
        Scanner optC = new Scanner(System.in);
        String chooseC = optC.nextLine();
        System.out.println(" ");
        return chooseC;
    }
    
    public static void eProfile(String user)
    {
        PreparedStatement egot = conn.prepareStatement("select * from staffMember where employeeID = ?"); 
        egot.setString(1,user);
        ResultSet Edata=egot.executeQuery();
        int addrID = Edata.getInt("addressID");

        PreparedStatement ead = conn.prepareStatement("select * from address where addressID = ?"); 
        ead.setString(1,addrID);
        ResultSet Eaddr=ead.executeQuery();

        System.out.println("Name: "+Edata.getString("firstName");+" "+Edata.getString("lastName");+"\nID: "+user+"\nJob Title: "+Edata.getString("jobTitle"););
        System.out.println("Address: "+Eaddr.getString("streetName")+" "+Eaddr.getInt("streetNumber")+" "+Eaddr.getString("city")+","+Eaddr.getChar("st"));
    }
    
    public static void cProfile(String user)
    {
        PreparedStatement ugot = conn.prepareStatement("select * from customer where customerID = ?"); 
        ugot.setString(1,user);
        ResultSet Udata=ugot.executeQuery();
        int uaddrID = Udata.getInt("addressID");

        PreparedStatement uad = conn.prepareStatement("select * from address where addressID = ?"); 
        uad.setString(1,uaddrID);
        ResultSet Uaddr=uad.executeQuery();

        System.out.println("Name: "+Udata.getString("firstName");+" "+Udata.getString("lastName");+"\nID: "+user+"\nCredit Card Number: "+Udata.getInt("ccNumber")+"\nCurrent Balance:"+Udata.getInt("currentBalance"));
        System.out.println("Address: "+Uaddr.getString("streetName")+" "+Uaddr.getInt("streetNumber")+" "+Uaddr.getString("city")+","+Uaddr.getChar("st"));
    }
}