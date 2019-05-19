/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mistria;

import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.ComboBox;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

/**
 * FXML Controller class
 *
 * @author narci
 */
public class AfterloginmainController implements Initializable 
{
    private Connection con;
    
    @FXML
    private BorderPane borderpane1;
    @FXML
    private ComboBox<String> departureContinent;
    @FXML
    private ComboBox<String> arrivalContinent;
    @FXML
    private ComboBox<String> departureCountry;
    @FXML
    private ComboBox<String> arrivalCountry;
    @FXML
    private ComboBox<String> departureCity;
    @FXML
    private ComboBox<String> arrivalCity;
    @FXML
    private ComboBox<String> departureAirport;
    @FXML
    private ComboBox<String> arrivalAirport;
    @FXML
    private ComboBox<String> holidayCity;
    @FXML
    private ComboBox<String> hotel;
    @FXML
    private ChoiceBox<String> citiesVisit;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return;
        }
        
        try {
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mistria", "mistria");
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
        
        System.out.println("Connected to SQL");
        
        // TODO
    }    

    @FXML
    private void historic(ActionEvent event) 
    {
        
        try 
        {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("historic.fxml"));
        Parent root1 = (Parent) fxmlLoader.load();
        Stage stage = new Stage();
        stage.setScene(new Scene(root1));
        stage.show();
        }
        catch(IOException e)
                {
                    System.err.println(e.getMessage());
                }
        
    }

    @FXML
    private void accsettings(ActionEvent event)
    {
        
        try 
        {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("accsettings.fxml"));
        Parent root1 = (Parent) fxmlLoader.load();
        Stage stage = new Stage();
        stage.setScene(new Scene(root1));
        stage.show();
        }
        catch(IOException e)
                {
                    System.err.println(e.getMessage());
                }
        
    }

    @FXML
    private void logout(MouseEvent event)
    {  
        loadUI("MistriaMain");
    }
    
     private void loadUI(String ui)
    {
       Parent root = null;
        try
        {
            root = FXMLLoader.load(getClass().getResource(ui+".fxml"));
        }
        catch(IOException ex)
        {
            Logger.getLogger(MistriaMainController.class.getName()).log(Level.SEVERE, null, ex);
        }
        borderpane1.setCenter(root);
    }

     

    @FXML
    private void departureContinent(MouseEvent event) 
    {
        departureContinent.getItems().clear();
        
        Statement statement;
        String query = "select c.name as name from continents c order by c.name";
        

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                departureContinent.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
        
        
    }

    @FXML
    private void arrivalContinent(MouseEvent event) 
    {
        arrivalContinent.getItems().clear();
        
        Statement statement;
        String query = "select c.name as name from continents c order by c.name";
        

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                arrivalContinent.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    @FXML
    private void departureCountry(MouseEvent event) 
    {
        
        departureCountry.getItems().clear();
        
        if(departureContinent.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select c.name as name from countries c where c.continent = \'" + departureContinent.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                departureCountry.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    @FXML
    private void arrivalCountry(MouseEvent event) 
    {
        arrivalCountry.getItems().clear();
        
        if(arrivalContinent.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select c.name as name from countries c where c.continent = \'" + arrivalContinent.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                arrivalCountry.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    @FXML
    private void departureCity(MouseEvent event) 
    {
        departureCity.getItems().clear();
        
        if(departureCountry.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select c.name as name from cities c join airports a on c.name = a.city where c.country = \'" + departureCountry.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                departureCity.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    @FXML // Facut un select astfel incat sa arate doar orasele care au aeroporturi
    private void arrivalCity(MouseEvent event) 
    {
       arrivalCity.getItems().clear();
        
        if(arrivalCountry.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select distinct c.name as name from cities c join airports a on c.name = a.city where country = \'" + arrivalCountry.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                arrivalCity.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        } 
    }

    @FXML
    private void departureAirport(MouseEvent event) 
    {
        departureAirport.getItems().clear();
        
        if(departureCity.getSelectionModel().getSelectedItem()== null)
             return;
        
        System.out.println(departureAirport.getVisibleRowCount());
        
        Statement statement;
        String query = "select a.name as name from airports a where a.city = \'" + departureCity.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                departureAirport.getItems().add(result.getString("name"));
            }
            
            departureAirport.hide();
            departureAirport.setVisibleRowCount(Math.min(10, departureAirport.getItems().size()));
//            departureAirport.setVisibleRowCount(20);
            System.out.println(departureAirport.visibleRowCountProperty());
            departureAirport.show();
            
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
        

        
    }

    @FXML
    private void arrivalAirport(MouseEvent event) 
    {
        arrivalAirport.getItems().clear();
        
        if(arrivalCity.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select a.name as name from airports a where a.city = \'" + arrivalCity.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            //int i = 0;
            while(result.next()) {
//                System.out.println(result.getString("name"));
                arrivalAirport.getItems().add(result.getString("name"));
                //i++;
            }
            
                    //departureAirport.setVisibleRowCount(Math.min(10,i));
            
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    @FXML
    private void holidayCity(MouseEvent event) 
    {
        holidayCity.getItems().clear();
        
        if(arrivalCountry.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select c.name as name from cities c where c.country = \'" + arrivalCountry.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                holidayCity.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        } 
    }

    @FXML
    private void hotel(MouseEvent event)
    {
        hotel.getItems().clear();
        
        if(holidayCity.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select h.name as name from hotels h where h.country = \'" + holidayCity.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                hotel.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        } 
    }

    @FXML // AICI NU MERG SELECTATE MAI MULTE
    private void citiesVisit(MouseEvent event) 
    {
        citiesVisit.getItems().clear();
        
        if(arrivalCountry.getSelectionModel().getSelectedItem()== null)
             return;
        
        Statement statement;
        String query = "select c.name as name from cities c where c.country = \'" + arrivalCountry.getSelectionModel().getSelectedItem() + "\' order by name";
        
//        System.out.println (query);

        try {
            statement = con.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()) {
//                System.out.println(result.getString("name"));
                citiesVisit.getItems().add(result.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        } 
    }
    
        
}
        
    

