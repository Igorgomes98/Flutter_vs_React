import React, { Component } from 'react';
import {
  View,
  Text,
  FlatList,
  ActivityIndicator,
  SafeAreaView,
  TextInput
} from 'react-native'
import { ListItem } from "react-native-elements";
import _ from "lodash";
import { getCities, contains } from "./api/index";

export default class SearchApp extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: false,
      data: [],
      error: null,
      query: "",
      fullData: [],
    };
  }

  componentDidMount() {
    this.makeRemoteRequest();
  }

  makeRemoteRequest = () => {
    this.setState({ loading: true });

    getCities().then(
      users => {
        this.setState({
          loading: false,
          data: users,
          fullData:users,
        });
      }).catch(error => {
        this.setState({ error, loading: false });
      });
  };

  handleSearch = (text) =>{
    const formatQuery = text.toLowerCase();
    const data = _.filter(this.state.fullData, user =>{
       return contains(user, formatQuery);
    });
    this.setState({query: formatQuery,data});
  };
  renderSeparator = () => {
    return (
      <View
        style={{
          height: 1,
          width: "86%",
          backgroundColor: "#CED0CE",
          marginLeft: "14%"
        }}
      />
    );
  };
  renderHeader = () => {
    return <TextInput  onChangeText={this.handleSearch} />
  };
  renderFooter = () => {
    if (!this.state.loading) return null;

    return (
      <View
        style={{
          paddingVertical: 20,
          borderTopWidth: 1,
          borderColor: "#CED0CE"
        }}
      >
        <ActivityIndicator animating size="large" />
      </View>
    );
  };
  render() {
    return (
      <SafeAreaView>
        <View containerStyle={{ borderTopWidth: 0, borderBottomWidth: 0 }}>
          <FlatList
            data={this.state.data}
            renderItem={({ item }) => (
              <ListItem
                roundAvatar
                title={`${item.city}`}
                //subtitle={item.email}
                //avatar= {{uri: item.picture.thumbnail}}
                containerStyle={{ borderBottomWidth: 0 }}
              />
            )}
            keyExtractor={item => item.city}
            ItemSeparatorComponent={this.renderSeparator}
            ListHeaderComponent={this.renderHeader}
            ListFooterComponent={this.renderFooter}
          />
        </View>
      </SafeAreaView>
    );
  }
}