using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CouponModule
{
    public partial class Form1 : Form
    {
        private string conn = ConfigurationManager.ConnectionStrings["connection_string"].ConnectionString;
        private SqlConnection connection;
        private SqlCommand command;
        DataGridViewLinkColumn button;
        public static Form1 instance;
        public ComboBox cb2;
        public ComboBox cb1;
        private bool hascoupons = false;
        public Form1()
        {
            InitializeComponent();
            LoadSecurityCombo();
            LoadStatusCombo();
            instance = this;
            cb2 = comboBox2;
            cb1 = comboBox1;
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Form2 f2 = new Form2();
            f2.Show();
            this.Visible=false;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            dateTimePicker1.Format = DateTimePickerFormat.Custom;
            dateTimePicker1.CustomFormat = "dd/MM/yyyy";
            dateTimePicker2.Format = DateTimePickerFormat.Custom;
            dateTimePicker2.CustomFormat = "dd/MM/yyyy";
            //if ((int)comboBox2.SelectedValue == 1)
            {
                //MessageBox.Show(comboBox2.SelectedValue.ToString());
                button = new DataGridViewLinkColumn();
                {
                    button.Name = "btn_edit";
                    button.HeaderText = "Actions";
                    button.Text = "edit";
                    button.UseColumnTextForLinkValue = true;
                    this.dataGridView1.Columns.Add(button);
                }
                DataGridViewLinkColumn button2 = new DataGridViewLinkColumn();
                {
                    button2.Name = "btn_delete";
                    button2.HeaderText = "";
                    button2.Text = "delete";
                    button2.UseColumnTextForLinkValue = true;
                    this.dataGridView1.Columns.Add(button2);
                }
                DataGridViewLinkColumn button3 = new DataGridViewLinkColumn();
                {
                    button3.Name = "btn_approve";
                    button3.HeaderText = "";
                    button3.Text = "approve";
                    button3.UseColumnTextForLinkValue = true;
                    //button3.UseColumnTextForButtonValue = true;
                    this.dataGridView1.Columns.Add(button3);
                }
                DataGridViewLinkColumn button4 = new DataGridViewLinkColumn();
                {
                    button4.Name = "btn_cancel";
                    button4.HeaderText = "Actions";
                    button4.Text = "cancel";
                    button4.UseColumnTextForLinkValue = true;
                    //button3.UseColumnTextForButtonValue = true;
                    this.dataGridView1.Columns.Add(button4);
                }
            }
           

            ShowData();
            //https://stackoverflow.com/a/45428195
            


        }
        public void LoadSecurityCombo()
        {
            //SqlDataAdapter da = new SqlDataAdapter("SELECT distinct isin_code,description FROM securities", conn);
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT distinct c.isin_code,s.description
                  FROM CouponsDB.dbo.coupons c
                left join CouponsDB.dbo.securities s
		                on c.isin_code = s.isin_code", conn);
            DataTable dt = new DataTable();
            dt.Columns.Add("description", typeof(string));
            dt.Rows.Add("--ALL--");

            da.Fill(dt);
            comboBox1.DataSource = dt;
            comboBox1.DisplayMember = "description";
            comboBox1.ValueMember = "isin_code";
            comboBox1.Width = SetWidthComboBox(comboBox1);
            //comboBox1.SelectedItem = null;
            //comboBox1.SelectedText = "";
        }
        public void LoadStatusCombo()
        {
            SqlDataAdapter da = new SqlDataAdapter(@"
              SELECT distinct c.status_id,sc.status_name
              FROM CouponsDB.dbo.coupons c
              left join CouponsDB.dbo.status_codes sc
		        on c.status_id = sc.status_id", conn);
            DataTable dt = new DataTable();
           
            da.Fill(dt);

            if (dt.Rows.Count != 0)
            {
                this.hascoupons = true;
            }
            else
            {
                this.hascoupons = false;
            }

            comboBox2.DataSource = dt;
            comboBox2.DisplayMember = "status_name";
            comboBox2.ValueMember = "status_id";
            comboBox2.Width = SetWidthComboBox(comboBox2);
            //comboBox2.SelectedItem = null;
            //comboBox2.SelectedText = "";
        }
        int SetWidthComboBox(ComboBox cb)
        {
            int maxWidth = 0, temp = 0;
            foreach (var obj in cb.Items)
            {
                temp = TextRenderer.MeasureText(cb.GetItemText(obj), cb.Font).Width;
                if (temp > maxWidth)
                {
                    maxWidth = temp;
                }
            }
            return maxWidth + SystemInformation.VerticalScrollBarWidth;
        }
        public void ShowData()//(int choice=1,string isin_code="")
        {
            try
            {
              
                //if (!hascoupons)
                //    {
                //        return;
                //    }
                        
                    string choice = "0";
                    string filter_security = "";
                    string filter_date = "";
                    var startdate = dateTimePicker1.Value.ToString("yyyy-MM-dd");
                    var enddate = dateTimePicker2.Value.ToString("yyyy-MM-dd");//.AddDays(1).ToString("yyyy-MM-dd");

                    if (hascoupons)
                    {
                        Int32 Val = 0;
                        if (Int32.TryParse(comboBox2.SelectedValue.ToString(), out Val))
                        {
                            choice = comboBox2.SelectedValue.ToString();
                            if (comboBox1.SelectedIndex > -1)
                            {
                                var isincode = comboBox1.SelectedValue.ToString();


                                if (!string.IsNullOrEmpty(isincode))// if (!(isincode== "--ALL--") )
                                    filter_security = $" and c.isin_code = '{isincode}'";

                            }
                        }
                    }
                    if (!string.IsNullOrEmpty(startdate) && !string.IsNullOrEmpty(enddate))
                    {
                        filter_date = $" and c.payment_date >= '{startdate}' and c.payment_date <= '{enddate}'";
                    }

                    using (connection = new SqlConnection(conn))
                    {
                        SqlDataAdapter da;

                        if (Int32.Parse(choice) == 1)
                        {
                            da = new SqlDataAdapter(
                           @"SELECT 
                        coupon_id as ID
                        , c.isin_code
                        , s.description as Security
                        , c.payment_date as 'Payment Date'
                        --, c.record_date
                        , c.status_id
                        , sc.status_name as Status
                        FROM CouponsDB.dbo.coupons c
                        left join CouponsDB.dbo.securities s
                            on c.isin_code = s.isin_code
                        left join CouponsDB.dbo.status_codes sc
                            on c.status_id = sc.status_id where c.status_id=" + choice + ""
                                + filter_security + ""
                                + filter_date + ""
                           , conn);
                            dataGridView1.Columns["btn_cancel"].Visible = false;
                            dataGridView1.Columns["btn_edit"].Visible = true;
                            dataGridView1.Columns["btn_delete"].Visible = true;
                            dataGridView1.Columns["btn_approve"].Visible = true;
                        }
                        else if (Int32.Parse(choice) == 2)
                        {
                            da = new SqlDataAdapter(
                            @"SELECT 
                            coupon_id as ID
                            , c.isin_code
                            , s.description as Security
                            , c.payment_date as 'Payment Date'
                            --, c.record_date
                            , c.status_id
                            , sc.status_name as Status
                            FROM CouponsDB.dbo.coupons c
                            left join CouponsDB.dbo.securities s
                                on c.isin_code = s.isin_code
                            left join CouponsDB.dbo.status_codes sc
                                on c.status_id = sc.status_id where c.status_id=" + choice + ""
                                    + filter_security + ""
                                    + filter_date + ""
                            , conn);
                            dataGridView1.Columns["btn_edit"].Visible = false;
                            dataGridView1.Columns["btn_delete"].Visible = false;
                            dataGridView1.Columns["btn_approve"].Visible = false;
                            dataGridView1.Columns["btn_cancel"].Visible = true;
                        }
                        else
                        {
                            da = new SqlDataAdapter(
                           @"SELECT 
                            coupon_id as ID
                            , c.isin_code
                            , s.description as Security
                            , c.payment_date as 'Payment Date'
                            --, c.record_date
                            , c.status_id
                            , sc.status_name as Status
                            FROM CouponsDB.dbo.coupons c
                            left join CouponsDB.dbo.securities s
                                on c.isin_code = s.isin_code
                            left join CouponsDB.dbo.status_codes sc
                                on c.status_id = sc.status_id 
                                where c.status_id=" + choice + ""
                                    + filter_security + ""
                                    + filter_date + ""
                           , conn);
                            dataGridView1.Columns["btn_cancel"].Visible = false;
                            dataGridView1.Columns["btn_edit"].Visible = false;
                            dataGridView1.Columns["btn_delete"].Visible = false;
                            dataGridView1.Columns["btn_approve"].Visible = false;
                        }
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        DataSet DS = new DataSet();
                        da.Fill(DS, "MyTable");
                        dataGridView1.DataSource = DS.Tables[0];
                        //var bindingSource = new BindingSource();
                        //bindingSource.DataSource = dt;

                        //dataGridView1.DataSource = bindingSource;
                        //dataGridView1.DataSource = dt.DefaultView;
                        //dataGridView1.DataSource = dt;


                        dataGridView1.Columns["isin_code"].Visible = false;
                        dataGridView1.Columns["status_id"].Visible = false;
                    }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex}");
            }
        }
        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int32 Val = 0;
            if (Int32.TryParse(comboBox2.SelectedValue.ToString(), out Val))
            {
                ShowData();
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox2.SelectedIndex>-1)
            {
                ShowData();
            }
        }

        //Known issue when debuggin date time picker:https://stackoverflow.com/a/44934775
        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {
                ShowData();
        }

        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
                ShowData();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //MessageBox.Show(dataGridView1.Columns[e.ColumnIndex].Name);
            if (dataGridView1.Columns[e.ColumnIndex].Name == "btn_delete")
            {
                if(MessageBox.Show("Are you sure you want to delete this entry?","Message",MessageBoxButtons.YesNo)==DialogResult.Yes)
                {
                    try
                    {
                        string coupon_id = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
                        using (connection = new SqlConnection(conn))
                        {
                            using (command = new SqlCommand($"Delete from coupons where coupon_id={coupon_id}", connection))
                            {
                                connection.Open();
                                command.ExecuteNonQuery();
                            }
                        }
                        LoadSecurityCombo();
                        LoadStatusCombo();
                        ShowData();
                        MessageBox.Show("Coupon Deletion Successfull!");
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Error: {ex}");
                    }
                }
            }
            if (dataGridView1.Columns[e.ColumnIndex].Name == "btn_edit")
            {
                var check = dataGridView1.Rows[e.RowIndex].Cells[1];
                try
                {
                    string coupon_id = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
                    using (connection = new SqlConnection(conn))
                    {
                        Form2 f2 = new Form2(true, dataGridView1, e.RowIndex);
                        f2.Show();
                        this.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error: {ex}");
                }
            }
            if (dataGridView1.Columns[e.ColumnIndex].Name == "btn_approve")
            {
                if (MessageBox.Show("Are you sure you want to Approve Coupon?", "Message", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    try
                    {
                        string coupon_id = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
                        int status_id = 2;//active record
                        using (connection = new SqlConnection(conn))
                        {
                            using (command = new SqlCommand($@"
                            Update coupons SET 
                            status_id='{status_id}'
                             where coupon_id='{coupon_id}'
                            ",
                            connection))
                            {
                                connection.Open();
                                command.ExecuteNonQuery();
                            }
                        }
                        ShowData();
                        LoadSecurityCombo();
                        LoadStatusCombo();
                        MessageBox.Show("Coupon Successfully Approved!");
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Error: {ex}");
                    }
                }
            }
            if (dataGridView1.Columns[e.ColumnIndex].Name == "btn_cancel")
            {
                if (MessageBox.Show("Are you sure you want to Cancel Coupon?", "Message", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    try
                    {
                        string coupon_id = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
                        int status_id = 3;//cancel record
                        using (connection = new SqlConnection(conn))
                        {
                            using (command = new SqlCommand($@"
                            Update coupons SET 
                            status_id='{status_id}'
                             where coupon_id='{coupon_id}'
                            ",
                            connection))
                            {
                                connection.Open();
                                command.ExecuteNonQuery();
                            }
                        }
                        MessageBox.Show("Coupon Successfully Cancelled!");
                        ShowData();
                        LoadSecurityCombo();
                        LoadStatusCombo();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Error: {ex}");
                    }
                }
            }
        }
    }
}
