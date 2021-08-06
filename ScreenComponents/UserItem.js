import React, { Component } from 'react';
import { Button, View, Text, StyleSheet, Image, TextInput, SafeAreaView, FlatList, TouchableOpacity } from 'react-native';
import { useSelector, useDispatch, connect } from 'react-redux';
import { setLikedUsers } from '../Redux/Actions'
 
export default function UserItem({ user }) {
    // const { userItem } = useSelector( state => state.userReducer);
    const dispatch = useDispatch();
    return (
      <View style={styles.listItem}>
        <Image source={{ uri: user.picture }} style={{ width: 60, height: 60, borderRadius: 30 }} />
        <View style={{ alignItems: 'center', flex: 1 }}>
          <Text style={{ fontWeight: "bold" }}>{user.name}</Text>
          <Text>{user.email}</Text>
          <Text>{user.phone}</Text>
        </View>
        <TouchableOpacity style={styles.buttonContainer} onPress={() => dispatch(setLikedUsers(user))} >
          <Text style={styles.button}>Like</Text>
        </TouchableOpacity>
      </View>
    );
  }

const styles = StyleSheet.create({
    listItem: {
      margin: 5,
      padding: 15,
      backgroundColor: "#FFF",
      width: "95%",
      flex: 1,
      alignSelf: "center",
      flexDirection: "row",
      borderRadius: 5
    },
    buttonContainer: { height: 50, 
      width: 50, 
      justifyContent: "center", 
      alignItems: "center" 
    },
    button: {
      color: "gray",
      fontWeight: '900'
    }
  });

  // const mapStateToProps = state  => ({
  //   user: state.user
  // }) 
  
  // export default connect(mapStateToProps)(UserItem)