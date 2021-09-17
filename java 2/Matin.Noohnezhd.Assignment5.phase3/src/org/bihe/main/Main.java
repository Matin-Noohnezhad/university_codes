package org.bihe.main;

import javax.swing.UIManager;

import org.bihe.DAO.UserPassDAO;

public class Main {

	public static void main(String[] args) {
		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		MainFrame frame = GUIManager.getMainFrame();
		GUIManager.addLoginPanelToCenter();
		UserPassDAO upd = UserPassDAO.getInstance();
		upd.addAdminAsAFirstOne();
		// new MyFrame().setVisible(true);
		frame.setVisible(true);

	}

}
