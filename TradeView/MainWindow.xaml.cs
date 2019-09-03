using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace TradeView
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();
		}

		private void DataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{

		}

		private void Window_Loaded(object sender, RoutedEventArgs e)
		{

			TradeView._Models_MarketDataDataSet _Models_MarketDataDataSet = ((TradeView._Models_MarketDataDataSet)(this.FindResource("_Models_MarketDataDataSet")));
			// Load data into the table V_Exposure. You can modify this code as needed.
			TradeView._Models_MarketDataDataSetTableAdapters.V_ExposureTableAdapter _Models_MarketDataDataSetV_ExposureTableAdapter = new TradeView._Models_MarketDataDataSetTableAdapters.V_ExposureTableAdapter();
			_Models_MarketDataDataSetV_ExposureTableAdapter.Fill(_Models_MarketDataDataSet.V_Exposure);
			System.Windows.Data.CollectionViewSource v_ExposureViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("v_ExposureViewSource")));
			v_ExposureViewSource.View.MoveCurrentToFirst();
			// Load data into the table V_Orders. You can modify this code as needed.
			TradeView._Models_MarketDataDataSetTableAdapters.V_OrdersTableAdapter _Models_MarketDataDataSetV_OrdersTableAdapter = new TradeView._Models_MarketDataDataSetTableAdapters.V_OrdersTableAdapter();
			_Models_MarketDataDataSetV_OrdersTableAdapter.Fill(_Models_MarketDataDataSet.V_Orders);
			System.Windows.Data.CollectionViewSource v_OrdersViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("v_OrdersViewSource")));
			v_OrdersViewSource.View.MoveCurrentToFirst();
			// Load data into the table Orders. You can modify this code as needed.
			TradeView._Models_MarketDataDataSetTableAdapters.OrdersTableAdapter _Models_MarketDataDataSetOrdersTableAdapter = new TradeView._Models_MarketDataDataSetTableAdapters.OrdersTableAdapter();
			_Models_MarketDataDataSetOrdersTableAdapter.Fill(_Models_MarketDataDataSet.Orders);
			System.Windows.Data.CollectionViewSource ordersViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("ordersViewSource")));
			ordersViewSource.View.MoveCurrentToFirst();
			// Load data into the table Analysis. You can modify this code as needed.
			TradeView._Models_MarketDataDataSetTableAdapters.AnalysisTableAdapter _Models_MarketDataDataSetAnalysisTableAdapter = new TradeView._Models_MarketDataDataSetTableAdapters.AnalysisTableAdapter();
			_Models_MarketDataDataSetAnalysisTableAdapter.Fill(_Models_MarketDataDataSet.Analysis);
			System.Windows.Data.CollectionViewSource analysisViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("analysisViewSource")));
			analysisViewSource.View.MoveCurrentToFirst();
		}

		private void OrdersDataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{

		}

		private void OrdersDataGrid_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{

		}
	}
}
