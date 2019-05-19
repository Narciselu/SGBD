/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mistria;

import java.math.BigInteger;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Region;

/**
 * FXML Controller class
 *
 * @author narci
 */
public class RegisterwindowController implements Initializable 
{

    @FXML
    private TextField firstName;
    @FXML
    private TextField lastName;
    @FXML
    private TextField email;
    @FXML
    private PasswordField password;
    
    private Connection con;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) 
    {
        // TODO
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
    }    

    @FXML
    private void createAcc(MouseEvent event) 
    {
        if(con == null){
            System.out.println("Not connected to SQL");
            return;
        }
        
        String fname = this.firstName.getText();
        String lname = this.lastName.getText();
        String email = this.email.getText();
        String password = hashPassword(this.password.getText());
        
//        System.out.println("mistria.RegisterwindowController.createAcc(): " + password);
        
        if(fname.length() == 0 || lname.length() == 0 || email.length() == 0 || password.length() < 4) {
//            System.out.println("All fields are required");
            showError("All field are required");
            return;
        }
        
        if(!email.matches("^([A-Za-z0-9\\.\\-\\_]+)@([A-Za-z]+)\\.([A-Za-z]+)$")){
//            System.out.println("Invalid email");
            showError("Invalid email");
            return;
        }
        
        try {
            PreparedStatement prepStmt = con.prepareStatement("insert into customers(email, first_name, last_name, password) values(?, ?, ?, ?)");
            prepStmt.setString(1, email);
            prepStmt.setString(2, fname);
            prepStmt.setString(3, lname);
            prepStmt.setString(4, password);
            prepStmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
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
        Alert alert = new Alert(AlertType.ERROR, err, ButtonType.OK);
            alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
            alert.show();
    }
    
}
