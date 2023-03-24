# 介绍

这里是玲珑软件的构建集成仓库，用于玲珑软件的自动化集成。

在这里添加的软件包会在 <https://build.deepin.com> 自动构建，并在构建后发布到 <https://ci.deepin.com/repo/linglong>（仓库还没准备好）

## 添加软件包

1. Fork 并 Clone 这个仓库到本地
2. 在本地仓库执行 `osc mkpac $包名` 创建包 (osc可使用apt安装)
3. 在 `$包名` 目录创建一个 _service 文件（[文件参考](#service参考)）
4. 使用 `git commit` 和 `git push` 提交变动，并对本仓库发起 PR
5. 等待审核通过，PR 合并后会触发自动添加包，并进行构建

## 删除软件包

1. Fork 并 Clone 这个仓库到本地
2. 在本地仓库执行 `osc delete $包名`
3. 使用 `git commit` 和 `git push` 提交变动，并对本仓库发起 PR
4. 等待审核通过，PR 合并后会触发自动删除包

## service参考

可使用以下模板，仅修改url参数和revision参数，其他保持不变。

```xml
<services>
  <service name="obs_scm">
    <param name="url">git url</param>
    <param name="revision">git tag</param>
    <param name="scm">git</param>
    <param name="exclude">.git</param>
    <param name="extract">*</param>
  </service>
  
  <service name="linglong">
    <param name="file">_service:obs_scm:linglong.yaml</param>
  </service>
</services>

```

## 使用仓库

TODO

## 注意事项

- 仅支持 git 类型的源码，linglong.yaml 的 source 不要使用 local 和 archive 。
- 暂不支持从源码拉取依赖，linglong.yaml 的 depends 不要使用 git 仓库。
- patch 文件和 linglong.yaml 需要一起放在 git 仓库的顶层目录。