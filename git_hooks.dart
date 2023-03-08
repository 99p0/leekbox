import 'package:git_hooks/git_hooks.dart';
import 'package:process_run/shell.dart';

void main(List<String> arguments) {
  Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit
  };
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  String commitMsg = Utils.getCommitEditMsg();
  // 规范提交日志
  if (commitMsg.startsWith('Feat:') ||
      commitMsg.startsWith('Fix:') ||
      commitMsg.startsWith('Refactor:') ||
      commitMsg.startsWith('Style:') ||
      commitMsg.startsWith('Docs:') ||
      commitMsg.startsWith('Test:') ||
      commitMsg.startsWith('Chore:') ||
      commitMsg.startsWith('Merge')) {
    return true;
  } else {
    print('请在提交文案添加前缀');
    return false;
  }
}

/// 在 git commit 的完成前执行
Future<bool> preCommit() async {
  final shell = Shell();
  // 提交文案
  String commitMsg = Utils.getCommitEditMsg();

  // 获取当前分支名
  var branchRes = await shell.run('git branch --show-current');
  String branch = branchRes.first.stdout;

  bool increaseBuildNum = false;

  // 自动增加build号时机
  if (commitMsg.startsWith("Merge")) {
    increaseBuildNum = false;
  } else {
    if (branch.startsWith('v')) {
      increaseBuildNum = true;
    } else {
      if (commitMsg.startsWith("Feat") || commitMsg.startsWith("Fix")) {
        increaseBuildNum = true;
      } else {
        increaseBuildNum = false;
      }
    }
  }
  print('increaseBuildNum:: $increaseBuildNum');
  if (increaseBuildNum) {
    try {
      /// 执行增加build 号
      var result = await shell.run('sh increase_build_num.sh');
      print('increaseBuildNum build result:: $result');
      return true;
    } catch (e) {
      print('increaseBuildNum error :: $e');
      return false;
    }
  } else {
    return true;
  }
}
