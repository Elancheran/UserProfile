import React, { Component } from 'react';
import { Button, View, Text, StyleSheet, Image , TextInput, TouchableHighlight} from 'react-native';


export default class LoginScreen extends Component {
    state = { userName: '', email: '', password: '', errorText: '' };

    render() {
     return(
      <View style={styles.container}>
          <Text style={styles.errorTextStyle}>{ this.state.errorText}</Text>
          <TextInput
          style = {styles.inputStyle}
          placeholder= 'Enter User name'
          onChangeText={text => this.setState({ userName: text})}
          />
        <TextInput
          style = {styles.inputStyle}
          onChangeText={text => this.setState({ email: text})}
          placeholder="Enter Email ID"
          clearButtonMode = 'while-editing'
        />
       <TextInput
         style = {styles.inputStyle}
         secureTextEntry
         placeholder = "Password"
         onChangeText={text => this.setState({ password: text})}
      />

      {/* <TouchableHighlight onPress={this.loginTap.bind(this)} underlayColor="white">
          <View style={styles.buttonStyle}>
            <Text style={styles.buttonText}>Sign Up</Text>
          </View>
        </TouchableHighlight> */}
        
      <Button
            title = "Sign Up"
            color = 'blue'
            onPress={this.loginTap.bind(this)}
          />
    </View>
    );
  }

  loginTap() {

    if (this.state.userName != '' && this.state.email != '' && this.state.password != '') {
      if (this.emailValidation(this.state.email) === false) {
        this.setState({ errorText: "Invalid EmailID"})
      }
      else {
        this.setState({ errorText: ''})
        this.props.navigation.navigate('Home', { name: 'User name', email: 'user Email' });
      }
    }
      
  }

  emailValidation = (text) => {
    console.log(text);
    let reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (reg.test(text) === false) {
      this.setState({ email: text})
      return false;
    }
    else {
      this.setState({ email: text})
    }
  }
}

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: '#fff',
      alignItems: 'center',
      justifyContent: 'center',
    },
    textContainer: {
      flex: 1,
      backgroundColor: '#fff',
      alignItems: 'center',
      justifyContent: "space-between"
    },
    errorTextStyle: {
      color: '#f00',
    },
    inputStyle: {
      borderColor: 'lightgrey',
      borderWidth: 1,
      borderRadius: 5,
      width: '80%',
      height: 50,
      margin: 10,
      padding: 10
    },
    buttonStyle: {
      height: 40,
      width: '60%',
      borderRadius: 20,
      alignItems: 'center',
      padding: 20,
      backgroundColor: 'cornflowerblue'
    },
    buttonText: {
      color: 'white'
    }
  });
  