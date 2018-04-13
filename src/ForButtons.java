import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.sql.Timestamp;


public class ForButtons{
    //В зависимости от вывыбранной кнопки вызываются соответсвующие функции создания нового окна
    ForButtons(int i) throws SQLException {
        JFrame jf = new JFrame();
        jf.setBounds(300, 100, 400, 300);
        jf.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        Operations op = new Operations();
        switch (i){
            case 1:{
                jf.setTitle("Вставка");
                JPanel mainPanel = new JPanel();
                //mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));

                JPanel panel1 = new JPanel(new FlowLayout());
                JPanel panel2 = new JPanel(new FlowLayout());

                JLabel label_id = new JLabel("id:");
                label_id.setHorizontalAlignment(SwingConstants.RIGHT);
                JLabel label_product = new JLabel("product:");
                JLabel label_cena = new JLabel("cena:");
                label_cena.setHorizontalAlignment(SwingConstants.RIGHT);

                JTextField text_id = new JTextField(20);
                JTextField text_product = new JTextField(20);
                JTextField text_cena = new JTextField(20);

                Box box = Box.createVerticalBox();

                Box bx1 = Box.createHorizontalBox();
                Box bx2 = Box.createHorizontalBox();
                Box bx3 = Box.createHorizontalBox();

                bx1.add(label_id);
                bx1.add(Box.createHorizontalStrut(6));
                bx1.add(text_id);
                box.add(bx1);
                box.add(Box.createVerticalStrut(10));

                bx2.add(label_product);
                bx2.add(Box.createHorizontalStrut(6));
                bx2.add(text_product);
                box.add(bx2);
                box.add(Box.createVerticalStrut(10));

                bx3.add(label_cena);
                bx3.add(Box.createHorizontalStrut(6));
                bx3.add(text_cena);
                box.add(bx3);
                box.add(Box.createVerticalStrut(10));
                panel1.add(box);

                label_id.setPreferredSize(label_product.getPreferredSize());
                label_cena.setPreferredSize(label_product.getPreferredSize());
                text_id.setPreferredSize(text_product.getPreferredSize());
                text_cena.setPreferredSize(text_product.getPreferredSize());

                JButton button_add = new JButton("Вставить");
                panel2.add(button_add);
                mainPanel.add(panel1);
                mainPanel.add(panel2);
                jf.add(mainPanel);
                jf.setVisible(true);
                button_add.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        try {
                            op.InsertInTable(Integer.parseInt(text_id.getText()),text_product.getText(),text_cena.getText());
                            jf.dispose();
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                    }
                });
                break;
            }
            case 2:{
                jf.setTitle("Обновление");
                JPanel mainPanel = new JPanel();
                //mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));

                JPanel panel1 = new JPanel(new FlowLayout());
                JPanel panel2 = new JPanel(new FlowLayout());
                JPanel panel3 = new JPanel(new FlowLayout());

                JLabel label_col = new JLabel("Название столбца:");
                JLabel label_value = new JLabel("Значение:");
                label_value.setHorizontalAlignment(SwingConstants.RIGHT);
                JLabel label_id = new JLabel("id:");
                label_id.setHorizontalAlignment(SwingConstants.RIGHT);

                JTextField text_id = new JTextField(20);
                JTextField text_value = new JTextField(20);
                JTextField text_col = new JTextField(20);

                Box box = Box.createVerticalBox();

                Box bx1 = Box.createHorizontalBox();
                Box bx2 = Box.createHorizontalBox();
                Box bx3 = Box.createHorizontalBox();

                bx1.add(label_col);
                bx1.add(Box.createHorizontalStrut(6));
                bx1.add(text_col);
                box.add(bx1);
                box.add(Box.createVerticalStrut(10));

                bx2.add(label_value);
                bx2.add(Box.createHorizontalStrut(6));
                bx2.add(text_value);
                box.add(bx2);
                box.add(Box.createVerticalStrut(10));

                bx3.add(label_id);
                bx3.add(Box.createHorizontalStrut(6));
                bx3.add(text_id);
                box.add(bx3);
                box.add(Box.createVerticalStrut(10));
                panel1.add(box);

                label_id.setPreferredSize(label_col.getPreferredSize());
                label_value.setPreferredSize(label_col.getPreferredSize());
                text_id.setPreferredSize(text_col.getPreferredSize());
                text_value.setPreferredSize(text_col.getPreferredSize());

                JButton button_add = new JButton("Обновить");
                panel2.add(button_add);
                mainPanel.add(panel1);
                mainPanel.add(panel2);
                jf.add(mainPanel);
                jf.setVisible(true);
                button_add.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        try {
                            op.UpdateTable(text_col.getText(),text_value.getText(),Integer.parseInt(text_id.getText()));
                            jf.dispose();
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                    }
                });
                break;
            }
            case 3:{
                jf.setTitle("Удаление");
                JPanel mainPanel = new JPanel();
                mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));

                JPanel panel1 = new JPanel(new FlowLayout());
                JPanel panel2 = new JPanel(new FlowLayout());

                JLabel label_id = new JLabel("id:");

                JTextField text_id = new JTextField(20);

                panel1.add(label_id);
                panel1.add(text_id);
                mainPanel.add(panel1);

                JButton button_add = new JButton("Удалить");
                panel2.add(button_add);

                mainPanel.add(panel2);

                jf.add(mainPanel);
                jf.setVisible(true);

                button_add.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        try {
                            op.DeleteFromTable(Integer.parseInt(text_id.getText()));
                            jf.dispose();
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                    }
                });
                break;
            }
            case 4:{
                jf.setTitle("Журнал");
                jf.setBounds(300, 100, 830, 320);

                JPanel mainPanel = new JPanel();
                mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));

                JPanel jp = new JPanel();

                JTable table;
                table = op.getData("journal_history");
                table.setEnabled(false);
                //table.setPreferredSize(new Dimension(600,200));
                table.setPreferredScrollableViewportSize(new Dimension(800,165));
                table.setFillsViewportHeight(true);

                JScrollPane scrollPane = new JScrollPane(table);
                jp.add(scrollPane);
                mainPanel.add(jp);

                JPanel fields = new JPanel(new FlowLayout());
                JLabel jlNum = new JLabel("Кол-во операций");
                JLabel jlTime = new JLabel("До(время)");
                JTextField jtxNum = new JTextField(10);
                JTextField jtxTime = new JTextField(20);

                fields.add(jlNum);
                fields.add(jtxNum);
                fields.add(jlTime);
                fields.add(jtxTime);

                mainPanel.add(fields);

                JPanel jp_buttons = new JPanel(new FlowLayout());

                JButton button1 = new JButton("Откат по количеству операций");
                JButton button2 = new JButton("Откат по времени");
                JButton button3 = new JButton("Восстановить");
                jp_buttons.add(button1);
                jp_buttons.add(button2);
                jp_buttons.add(button3);
                jp_buttons.setPreferredSize(new Dimension(600,50));
                mainPanel.add(jp_buttons);
                jf.add(mainPanel);
                jf.setVisible(true);

                button1.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        try {
                            op.backNum(Integer.parseInt(jtxNum.getText()));
                            table.setModel(op.getData("journal_history").getModel());
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                    }
                });

                button2.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        try {
                            Timestamp ts = Timestamp.valueOf(jtxTime.getText());
                            op.backTime(ts);
                            table.setModel(op.getData("journal_history").getModel());
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                    }
                });

                button3.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        try {
                            op.func_return(Integer.parseInt(jtxNum.getText()));
                            table.setModel(op.getData("journal_history").getModel());
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                    }
                });
                break;
            }
        }
    }

}
