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
  if (commitMsg.startsWith('feat: ') || // feat: 新功能（feature）
      commitMsg.startsWith('fix: ') || //fix: 修补bug
      commitMsg.startsWith('perf: ') || //perf: 性能优化
      commitMsg
          .startsWith('refactor: ') || //refactor: 重构（即不是新增功能，也不是修改bug的代码变动）
      commitMsg.startsWith('style: ') || //style: 格式（不影响代码运行的变动）
      commitMsg.startsWith('docs: ') || //docs: 文档（documentation）
      commitMsg.startsWith('test: ') || //test：测试
      commitMsg.startsWith('revert: ') || //revert: 撤销，版本回退
      commitMsg.startsWith('ci: ') || //ci: 持续集成相关文件修改
      commitMsg.startsWith('chore: ') || //chore: 构建过程或辅助工具的变动
      commitMsg.startsWith('build: ') || //build: 打包
      commitMsg.startsWith('merge: ')) {
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

  // 修复，增加新功能
  if (commitMsg.startsWith("feat") ||
      commitMsg.startsWith("fix") ||
      commitMsg.startsWith("build")) {
    increaseBuildNum = true;
  } else {
    increaseBuildNum = false;
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
