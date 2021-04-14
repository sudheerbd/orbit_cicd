import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class GenerateBranchNames {
	public static void main(String[] args) {
		try {
			if (args.length >= 2) {
				String command = "git --git-dir=" + args[0]
						+ "\\.git for-each-ref --format=%(refname:strip=3) refs/remotes/origin";
				System.out.println(command);
				Process child = Runtime.getRuntime().exec(command);
				BufferedReader reader = new BufferedReader(new InputStreamReader(child.getInputStream()));
				List<String> branches = new ArrayList<>();
				String line = "";
				while ((line = reader.readLine()) != null) {
					if ("HEAD".equals(line))
						continue;
					branches.add(line);
				}
				reader.close();
				String props = "branches=";
				StringBuilder sb1 = new StringBuilder();
				sb1.append(props);
				if (!branches.isEmpty()) {
					for (String string : branches) {
						sb1.append(string + ",");
					}
				}
				String finalProperties = sb1.substring(0, sb1.lastIndexOf(","));
				BufferedWriter bwr = new BufferedWriter(new FileWriter(args[1]));
				bwr.write(finalProperties);
				bwr.flush();
				bwr.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}