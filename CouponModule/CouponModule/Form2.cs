using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace CouponModule
{
    public partial class Form2 : Form
    {
        private string conn = ConfigurationManager.ConnectionStrings["connection_string"].ConnectionString;
        private SqlConnection connection;
        private SqlCommand command;
        private bool isEditView;
        private DataGridView dataGridView1f1 ;
        private int RowIndexf1;
        public Form2(bool isEditView = false, DataGridView dataGridView1f1=null,int RowIndexf1=-1)
        {
            InitializeComponent();
            dateTimePicker1.Value = DateTime.Now;
            this.isEditView = isEditView;
            this.dataGridView1f1 = dataGridView1f1;
            this.RowIndexf1 = RowIndexf1; 
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            LoadSecurityCombo();
            if (isEditView)
                LoadStatusCombo();
            SetupView();
           
        }
        void SetupView()
        {
            if (!isEditView)//default status is pending
            {
                comboBox2.Visible = false;
                label3.Visible = false;
                List<object> localstatus = new List<object>();
                localstatus.Add(new { status_id = 1, status_name = "PENDING" });
                comboBox2.DisplayMember = "status_name";
                comboBox2.ValueMember = "status_id";
                comboBox2.DataSource = localstatus;
                button1.Text = "ADD";
            }
            else
            {
                button1.Text = "EDIT";
                string security = dataGridView1f1.Rows[RowIndexf1].Cells[6].Value.ToString();
                string status = dataGridView1f1.Rows[RowIndexf1].Cells[9].Value.ToString();
                comboBox1.SelectedIndex = comboBox1.FindStringExact(security);
                comboBox2.SelectedIndex = comboBox2.FindStringExact(status);
                dateTimePicker1.Value = DateTime.Parse(dataGridView1f1.Rows[RowIndexf1].Cells[7].Value.ToString());
            }
        }
        void LoadStatusCombo()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT status_id, status_name FROM status_codes", conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            comboBox2.DataSource = dt;
            comboBox2.DisplayMember = "status_name";
            comboBox2.ValueMember = "status_id";
            comboBox2.Width = SetWidthComboBox(comboBox2);
        }
        void LoadSecurityCombo()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT distinct isin_code,description FROM securities", conn);
            DataTable dt = new DataTable();
            //dt.Columns.Add("description", typeof(string));
            //dt.Rows.Add("--ALL--");
            da.Fill(dt);
            comboBox1.DataSource = dt;
            comboBox1.DisplayMember = "description";
            comboBox1.ValueMember = "isin_code";
            comboBox1.Width = SetWidthComboBox(comboBox1);
            comboBox1.SelectedItem = null;
            comboBox1.SelectedText = "";
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

        private void button1_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem == null)
            {
                comboBox1.Focus();
                errorProvider1.SetError(comboBox1, "Please Select Item From Dropdown !");
                label4.Text = "Please Select Item From Dropdown !";
            }
            else
            {
                label4.Text = "";
                errorProvider1.Clear();
                if (!isEditView)
                    AddCoupon();
                else
                    EditCoupon();
            }
        }
        void EditCoupon()
        {
            try
            {
                string coupon_id = dataGridView1f1.Rows[RowIndexf1].Cells[4].Value.ToString();
                string isin_code = comboBox1.SelectedValue.ToString();
                var payment_date = DateTime.Parse(dateTimePicker1.Value.ToString("yyyy-MM-dd"));
                var record_date = DateTime.Now.ToString("yyyy-MM-dd");
                string status_id = comboBox2.SelectedValue.ToString();
                using (connection = new SqlConnection(conn))
                {
                    using (command = new SqlCommand($@"
                Update coupons SET 
                isin_code='{isin_code}'
                ,payment_date='{payment_date}'
                ,record_date='{record_date}'
                ,status_id='{status_id}'
                 where coupon_id='{coupon_id}'
                ",
                    connection))
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                MessageBox.Show("Data Submitted Successfully!");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex}");
            }
        }
        void AddCoupon()
        {
            try
            {
                string isin_code = comboBox1.SelectedValue.ToString();
                var payment_date = DateTime.Parse(dateTimePicker1.Value.ToString("yyyy-MM-dd"));
                var record_date = DateTime.Now.ToString("yyyy-MM-dd");
                string status_id = comboBox2.SelectedValue.ToString();

                using (connection = new SqlConnection(conn))
                {
                    using (command = new SqlCommand($"INSERT INTO coupons VALUES ('{isin_code}','{payment_date}','{record_date}','{status_id}')", connection))
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                MessageBox.Show("Data Submitted Successfully!");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex}");
            }
        }

        private void Form2_FormClosed(object sender, FormClosedEventArgs e)
        {
            Form1.instance.Visible = true;
            Form1.instance.LoadStatusCombo();
            Form1.instance.LoadSecurityCombo();
            Form1.instance.ShowData();
        }
    }
}
