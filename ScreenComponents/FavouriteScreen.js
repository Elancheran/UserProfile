import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, Image, SafeAreaView, FlatList } from 'react-native';
import UserItem from './UserItem';
import { connect } from 'react-redux';
import { setLikedUsers } from '../Redux/Actions'


function FavouriteScreen() {

  useEffect(() => {
     console.log('userItem', users)
}, []);

const [users, setUser] = useState([])

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <View style={styles.container}>
        <FlatList
          data={users}
          renderItem={({ item }) => <FavUser user={item} />}
          keyExtractor={item => item._id}
        />
      </View>
    </SafeAreaView>
  );
}


const mapStateToProps = state  => ({
  users: state.users
}) 

export default connect(mapStateToProps)(FavouriteScreen)


function FavUser({ user }) {
  return (
    <View style={styles.listItem}>
      <Image source={{ uri: user.picture }} style={{ width: 60, height: 60, borderRadius: 30 }} />
      <View style={{ alignItems: 'center', flex: 1 }}>
        <Text style={{ fontWeight: "bold" }}>{user.name}</Text>
        <Text>{user.email}</Text>
        <Text>{user.phone}</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F7F7F7',
  },
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