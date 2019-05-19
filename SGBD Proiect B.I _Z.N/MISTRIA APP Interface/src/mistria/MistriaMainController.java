/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mistria;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.scene.layout.Region;
import javafx.stage.Stage;

/**
 *
 * @author narci
 */
public class MistriaMainController implements Initializable
{
    private Connection con;
    
    @FXML
    private TextField username;
    @FXML
    private PasswordField password;
    @FXML
    private BorderPane borderpane;
    
    
    @Override
    public void initialize(URL url, ResourceBundle rb) 
    {
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
        
//        System.out.println("Connected to SQL");
        // TODO
    }    

    @FXML
    private void login(MouseEvent event) 
    {
        
        loadUI("afterloginmain");
    }

    @FXML
    private void registerpage(ActionEvent event)
    {
        try 
        {
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("registerwindow.fxml"));
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
    
   //setarea care imi face butoanele sa functioneze 
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
        borderpane.setCenter(root);
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest msgDigest = MessageDigest.getInstance("MD5");
            msgDigest.reset();
            BigInteger bigInt = new BigInteger(1, msgDigest.digest());
            return bigInt.toString(16);
        } catch (NoSuchAlgorithmException ex) {
             System.out.println(ex.getMessage());
        }
        
        return null;
    }
    
    private void showError(String err){
        Alert alert = new Alert(Alert.AlertType.ERROR, err, ButtonType.OK);
            alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
            alert.show();
    }
}
