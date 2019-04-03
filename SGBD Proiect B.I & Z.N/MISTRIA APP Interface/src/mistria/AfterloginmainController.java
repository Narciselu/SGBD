/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mistria;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

/**
 * FXML Controller class
 *
 * @author narci
 */
public class AfterloginmainController implements Initializable {

    @FXML
    private BorderPane borderpane1;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
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
    private void departureContinent(ActionEvent event) {
        
    }

    
}
