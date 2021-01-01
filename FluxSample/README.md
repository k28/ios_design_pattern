# Flux Sample

## 簡単な構成

| クラス        | 説明                                                                             |
| -----         | -----                                                                            |
| Action        | 使用するAction, Store毎に分けたり、目的毎に分ける                                |
| ActionCreator | Actionを生成するクラス, シングルトン                                             |
| Dispatcher    | Actionを受け取りStoreに伝える. シングルトン                                      |
| Store         | 状態を保持し、Dispatcherから伝わったActionのtypeとデータに応じて、状態を更新する |
| View          | Storeの状態を監視してViewの状態を更新する                                        |


## Store

| クラス            | 説明                        |
| -----             | -----                       |
| TaskListStore     | タスクリストを保持するStore |
| TaskListViewStore | タスクリストViewのStore     |
| AddTaskViewStore  | タスク追加画面のStore       |
| CommonActionStore | 共通アクションのStpre       |

