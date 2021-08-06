import React, { Component } from 'react';
import { Button, View, Text, StyleSheet, Image, TextInput, SafeAreaView, FlatList, TouchableOpacity } from 'react-native';
import { useSelector, useDispatch } from 'react-redux';
import { setLikedUsers } from '../Redux/Actions';
import UserItem from './UserItem';

export default class HomeScreen extends Component {

  state = { users: [] }

  componentDidMount() {
    return fetch('http://www.json-generator.com/api/json/get/ceiNKFwyaa?indent=2')
      .then((response) => response.json())
      .then((responseJson) => {
        this.setState({ users: responseJson })
      })
      .catch((error) => {
        console.error(error);
      });
  }

  render() {
    return (
      <SafeAreaView style={{ flex: 1 }}>
        <View style={styles.container}>
          <FlatList
            data={this.state.users}
            renderItem={({ item }) => <UserItem user={item} />}
            keyExtractor={item => item._id}
          />
        </View>
      </SafeAreaView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F7F7F7',
  }
});