/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mistria;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Spinner;
import javafx.scene.control.SpinnerValueFactory;
import javafx.scene.input.MouseEvent;

/**
 * FXML Controller class
 *
 * @author narci
 */
public class HistoricController implements Initializable {

    @FXML
    private Spinner<Integer> rateHotel;
    @FXML
    private Spinner<Integer> rateCity;
    @FXML
    private Spinner<Integer> rateFlight;
    @FXML
    private ComboBox<Integer> lastTrip;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        
        //rateHotel
        SpinnerValueFactory<Integer> gradesValueFactory2 = new SpinnerValueFactory.IntegerSpinnerValueFactory(1,5,3);
        this.rateHotel.setValueFactory(gradesValueFactory2);
        //rateCity
        SpinnerValueFactory<Integer> gradesValueFactory3 = new SpinnerValueFactory.IntegerSpinnerValueFactory(1,5,3);
        this.rateCity.setValueFactory(gradesValueFactory3);
        //rateFlight
        SpinnerValueFactory<Integer> gradesValueFactory4 = new SpinnerValueFactory.IntegerSpinnerValueFactory(1,5,3);
        this.rateFlight.setValueFactory(gradesValueFactory4);
 
    }    

    @FXML
    private void rateHotel(MouseEvent event) {
    }

    @FXML
    private void rateCity(MouseEvent event) {
    }

    @FXML
    private void rateFlight(MouseEvent event) {
    }

    @FXML
    private void lastTrip(MouseEvent event) {
    }
    
}
