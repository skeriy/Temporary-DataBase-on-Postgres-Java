import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

// Основной класс отрисовывающий начальное окно с таблице и кнопки
public class MainWindow extends JFrame{
    private JTable table;
    private JButton button1;
    private JButton button2;
    private JButton button3;
    private JButton button4;
    private JButton button5;
    private Operations op;

    public MainWindow() throws SQLException{
        super("Таблица");
        setBounds(300, 100, 800, 300);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));

        JPanel jp = new JPanel();

        op = new Operations();
        table = op.getData("magazin");
        table.setEnabled(false);
        table.setPreferredScrollableViewportSize(new Dimension(750,165));
        table.setFillsViewportHeight(true);

        JScrollPane scrollPane = new JScrollPane(table);
        jp.add(scrollPane);
        mainPanel.add(jp);

        JPanel jp_buttons = new JPanel(new FlowLayout());

        button1 = new JButton("Обновить таблицу");
        button2 = new JButton("Добавить данные");
        button3 = new JButton("Обновить данные");
        button4 = new JButton("Удалить данные");
        button5 = new JButton("Журнал");
        jp_buttons.add(button1);
        jp_buttons.add(button2);
        jp_buttons.add(button3);
        jp_buttons.add(button4);
        jp_buttons.add(button5);
        jp_buttons.setPreferredSize(new Dimension(600,50));
        mainPanel.add(jp_buttons);
        add(mainPanel);

        initListeners();
    }

    private void initListeners() {
        button1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    table.setModel(op.getData("magazin").getModel());
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        });
        button2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    ForButtons add = new ForButtons(1);
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        });
        button3.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    ForButtons upd = new ForButtons(2);
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        });
        button4.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    ForButtons del = new ForButtons(3);
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        });
        button5.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    ForButtons journal = new ForButtons(4);
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        });
    }

    public static void main(String[] args) throws SQLException{
        MainWindow mw = new MainWindow();
        mw.setResizable(false);
        mw.setVisible(true);

    }





}
