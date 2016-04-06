
'use strict'

var React = require('react');
var Griddle = require('griddle-react');
var ReactDOM = require('react-dom');

var Button = require('react-bootstrap/lib/Button');
var Popover = require('react-bootstrap/lib/Popover');
var OverlayTrigger = require('react-bootstrap/lib/OverlayTrigger');

var moment = require('moment');

var DescriptionComponent;

String.prototype.capitalizeFirstLetter = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
};

DescriptionComponent = React.createClass({
  displayName: 'DescriptionComponent',
  componentDidMount: function() {
    
  },

  render: function(){
    return (
      <div>
        <OverlayTrigger trigger="click" placement="left" overlay={<Popover title={this.props.rowData.shift}>{this.props.rowData.description}</Popover>}>
          <Button color="blue" type="button">Description</Button>
        </OverlayTrigger>
      </div>
    );}
});

var UserComponent = React.createClass({
  displayName: 'UserComponent',
  getInitialState: function(){
    var full_name = this.props.rowData.user.full_name
    if (full_name) {
      full_name = full_name.capitalizeFirstLetter();
    }
    return {profile_url: "users/"+this.props.rowData.user.user_id,
            full_name: full_name
    }
  },
  
  render: function(){
    return (
      <a href={this.state.profile_url} className="btn btn-default" role="button">
        {this.state.full_name}
      </a>
      );
    
  }
  });

var columnMeta = [
  {
  "columnName": "shift",
  "displayName": "Work Shift",
  "order": 1,
  "locked": false,
  "visible": true,
  //"customComponent": DescriptionComponent
  },
  {
  "columnName": "user",
  "displayName": "User",
  "order": 4,
  "customComponent": UserComponent
  },
  {
  "columnName": "start_time",
  "displayName": "Start Time",
  "order" :2
  },
  {
  "columnName": "end_time",
  "displayName": "End Time",
  "order" :3
  },
  {
  "columnName": "description",
  "displayName": "Description",
  "order" :5,
  "customComponent": DescriptionComponent
  },
];

var columns = [
  'shift', 'user', 'start_time', 'end_time', 'description' 
  ];


var WorkShiftTable = React.createClass({
  propTypes: {
    title: React.PropTypes.string,
    //shifts: React.PropTypes.array
  },
  
  getInitialState: function() {
   return {shiftData: [
     {
    "shift": "Pans",
    "user": {"full_name":"Mayers Leonard",
                 "user_id" : 1},
    "start_time": "2PM",
    "end_time": "3PM",
    "description": "Pans description"
  },
  {
    "shift": "Kitchen",
    "user": {"full_name":"Mom",
                 "user_id" : 1},
    "start_time": "3PM",
    "end_time": "5PM",
    "description": "Kitchen description"
  },
  ]}
  },
  
  componentDidMount: function(){
    var shifts = this.props.shifts
    console.log(shifts)
    var data = []
    for (var i = 0; i < shifts.length; i++){
      var shift = shifts[i]
      data.push({"shift": shift.metashift.category,
        "user": {"full_name":shift.user.first_name +" " +shift.user.last_name,
                 "user_id" : shift.user_id},
        "start_time": moment(shift.start_time).format('llll'), 
        "end_time": moment(shift.end_time).format('llll'),
        "description": shift.metashift.description,
      })
    }
    console.log(data)
    if (shifts.length > 0) {
      this.setState({shiftData: data})
    } else{
      
    }
  },

  render: function() {
    return (
      <div>
        <Griddle results={this.state.shiftData}
        columnMetadata={columnMeta}
        columns={columns}
        showFilter={true}/>
      </div>
    );
  }
});


module.exports = WorkShiftTable

