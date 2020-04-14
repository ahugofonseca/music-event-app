import React, { Component } from 'react';
import { Row, Col, Button, Icon } from 'react-materialize'

class DynamicMultipleInput extends Component {
  constructor(props) {
    super(props)

    this.state = {
      fields: [],
      disabled: false
    }
  }

  resetFields() {
    this.setState({
      fields: [],
      disabled: false
    })
  }

  sendData = () => {
    this.props.getDataFields(this.state.fields);

    // Disabled buttons
    let disabled = true
    this.setState({
      disabled
    })
  }

  handleText = i => e => {
    let fields = [...this.state.fields]
    fields[i][e.target.name] = e.target.value;

    this.setState({
      fields
    })
  }

  handleDelete = i => e => {
    e.preventDefault()
    let fields = [
      ...this.state.fields.slice(0, i),
      ...this.state.fields.slice(i + 1)
    ]
    this.setState({
      fields
    })
  }

  addField = e => {
    e.preventDefault()

    let lastIndex = this.props.field.length-1
    let fieldsStr = '{'

    this.props.field.forEach((item, index) => {
      if (lastIndex == index) {
        fieldsStr += '"'+item+'": ""}'
      } else {
        fieldsStr += '"'+item+'": "",'
      }
    })

    let fields = this.state.fields.concat([
      JSON.parse(fieldsStr)
    ])

    this.setState({
      fields
    })
  }

  render() {
    return (
      <div>
        {this.state.fields.map((field, index) => (
          <Row key={index}>
            <Col m={10}>
              {Object.keys(field).map((key) => (
                <Col m={12/Object.keys(field).length} key={key}>
                  <input type="text"
                         name={key}
                         placeholder={key.capitalize()}
                         onChange={this.handleText(index)}
                         value={field[key]} />
                </Col>
              ))}
            </Col>
            <Col m={2}>
              <Button small={"true"}
                      waves="light"
                      style={{marginRight: '5px'}}
                      disabled={this.state.disabled}
                      onClick={this.handleDelete(index)}
                      key={"delete"+this.props.field+index}
                    >
                      <Icon>delete_forever</Icon>
              </Button>
            </Col>
          </Row>
        ))}
        <Button small={"true"}
                waves="light"
                style={{marginRight: '5px'}}
                disabled={this.state.disabled}
                onClick={this.addField}
                key={"add"+this.props.field.artist}
              >
                <Icon>add</Icon>
        </Button>
        <Button small={"true"}
                waves="light"
                style={{marginRight: '5px'}}
                disabled={this.state.disabled}
                onClick={this.sendData}
                key={"check"+this.props.field}
              >
                <Icon>check</Icon>
        </Button>
      </div>
    )
  }
}

export default DynamicMultipleInput;
