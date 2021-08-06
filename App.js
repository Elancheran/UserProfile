import { StatusBar } from 'expo-status-bar';
import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import {Text, View, Image, StyleSheet} from 'react-native';
import { Provider } from 'react-redux';
import { Store } from './Redux/Store';

import LoginScreen from './ScreenComponents/LoginScreen';
import HomeScreen from './ScreenComponents/HomeScreen';
import ProfileScreen from './ScreenComponents/ProfileScreen';
import FavouriteScreen from './ScreenComponents/FavouriteScreen';

const Stack = createStackNavigator();
const Tabs = createBottomTabNavigator();

function TabContainer() {
  return (
    <Tabs.Navigator>
      <Tabs.Screen name="User" component={HomeScreen} options={{ title: 'Users'}} />
      <Tabs.Screen name="Profile" component={ProfileScreen} options={{ title: 'My profile'}} />
      <Tabs.Screen name="FavouriteUser" component={FavouriteScreen} options={{ title: 'Favourite Users'}}/>
    </Tabs.Navigator>
  );
}


// let favContainer = connect(state => ({ count: state.users }))(FavouriteScreen);

const AppContainer = () => {
  return (
    <Provider store={Store}> 
   <NavigationContainer>
   <Stack.Navigator initialRouteName="Login">
     <Stack.Screen
       name="Login"
       component={LoginScreen}
       options={{
         title: 'User Login',
         headerTransparent: true,
       }}
     />
     <Stack.Screen name="Home" component={TabContainer} options={{ 
       headerBackTitleVisible: false,
     }}/>
   </Stack.Navigator>
 </NavigationContainer>
   </Provider>
  );
 };

export default function App() {
  return (
   <AppContainer/>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
