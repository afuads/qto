// register the editable
Vue.component('editable', {
  template: `
    <div v-bind:id="id" contenteditable="true" @blur="emitChange">
      {{ content }}
    </div>
  `,
  props: ['content','id'],
  methods: {
    emitChange (ev) {
      this.$emit('update', ev.target.textContent,ev.target.id)
    }
  }
})
// register the grid component
Vue.component('demo-grid', {
  template: '#grid-template',
  props: {
    data: Array,
    columns: Array,
    filterKey: String
  },
  data: function () {
    var sortOrders = {}
    this.columns.forEach(function (key) {
      sortOrders[key] = 1
    })
    return {
      sortKey: '',
      sortOrders: sortOrders
    }
  },
  computed: {
    filteredData: function () {
      var sortKey = this.sortKey
      var filterKey = this.filterKey && this.filterKey.toLowerCase()
      var order = this.sortOrders[sortKey] || 1
      var data = this.data
      if (filterKey) {
        data = data.filter(function (row) {
          return Object.keys(row).some(function (key) {
            return String(row[key]).toLowerCase().indexOf(filterKey) > -1
          })
        })
      }
      if (sortKey) {
        data = data.slice().sort(function (a, b) {
          a = a[sortKey]
          b = b[sortKey]
          return (a === b ? 0 : a > b ? 1 : -1) * order
        })
      }
      return data
    }
  },
  filters: {
    capitalize: function (str) {
      return str.charAt(0).toUpperCase() + str.slice(1)
    }
  },
  methods: {
    sortBy: function (key) {
      this.sortKey = key
      this.sortOrders[key] = this.sortOrders[key] * -1
    },
    updateItem (content,id) {
      var arr = id.split('-')
      var col = arr[0]
      var dbid = arr[1]
		console.log ( "new content: " + content ) 
		console.log ( "column: " + arr[0] )
		console.log ( "dbid: " + arr[1] )
      console.log ( "should run: UPDATE monthly_issues set " + col + " = '" + content + "' WHERE id='" + dbid + "'" )
      console.log ( "/dev_qto/update/monthly_issues?pick=id" + arr[1] ) 


         axios.post('/dev_qto/update/monthly_issues', {
             attribute: col,
             id: dbid
         })
         .then(function (response) {
            console.log(response);
         })
         .catch(function (error) {
            console.log(error);
          });

    }
  }
})

// bootstrap the demo
var demo = new Vue({
  el: '#demo',
  data: {
    searchQuery: '',
    gridColumns: ['id', 'name', 'prio','description'],
    gridData: []
  },
  mounted() {
    axios.get("/dev_qto/select/monthly_issues?pick=id,name,prio,description")
    .then(response => {this.gridData = response.data.dat
	 })
 },
})
