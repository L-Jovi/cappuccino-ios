import {
  Dimensions,
} from 'react-native'

export default {
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },

  containerShow: {
    flex: 2,
    backgroundColor: '#E08C80',
    paddingTop: 22,
  },

  containerControl: {
    flex: 1,
    backgroundColor: '#C2C2C2',
  },

  btn: {
    width: 88,
    height: 30,
    margin: 20,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#E08C80',
    borderWidth: 1,
    borderRadius: 3,
  },

  btnText: {
    fontSize: 15,
    fontWeight: 'bold',
    textAlign: 'center',
  },

  image: {
    margin: 30,
    width: 100,
    height: 100,
  },

  textShow: {
    margin: 30,
    color: '#F5F6F9',
    fontWeight: 'bold',
  },

  textMsg: {
    margin: 20,
    fontWeight: 'bold',
  },

  textProgress: {
    marginVertical: 10,
    marginHorizontal: 20,
  }
}
