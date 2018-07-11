export default {
  touchable: {
    onPress() {
      this.props.actions.isLoading(false)
    }
  }
}
