import pyltr
import pandas as pd
import pickle
import os


def train_model(train_path, val_path, test_path):
    with open(train_path) as trainfile, \
            open(val_path) as valfile, \
        open(test_path) as testfile:
        train_X, train_y, train_qids, _ = pyltr.data.letor.read_dataset(trainfile)
        val_X, val_y, val_qids, _ = pyltr.data.letor.read_dataset(valfile)
        test_X, test_y, test_qids, _ = pyltr.data.letor.read_dataset(testfile)
    metric = pyltr.metrics.NDCG(k=10)

    # Only needed if you want to perform valdation (early stopping & trimming)
    # monitor = pyltr.models.monitors.ValidationMonitor(
    #     val_X, val_y, val_qids, metric=metric, stop_after=250)

    model = pyltr.models.LambdaMART(
        metric=metric,
        n_estimators=1000,
        learning_rate=0.02,
        max_features=0.5,
        query_subsample=0.5,
        max_leaf_nodes=10,
        min_samples_leaf=64,
        verbose=1,
    )

    # model.fit(train_X, train_y, train_qids, monitor=monitor)
    model.fit(train_X, train_y, train_qids)
    # pickle.dump(model, open('..\\pickled_data\\lambdamart_model.pkl', 'wb'))

    metric = pyltr.metrics.NDCG(k=10)

    test_pred = model.predict(test_X)
    print('Random ranking:', metric.calc_mean_random(test_qids, test_y))
    print('Our model:', metric.calc_mean(test_qids, test_y, test_pred))

    return model


# def test_model(model, query_ids):
#     # load model
#     model = pickle.load(open(os.path.join('..', 'pickled_data', 'lambdamart_model.pkl')))
#
#     # evaluate model on test data:
#     with open(os.path.join('..', 'data', 'test.txt')) as testfile:
#         test_X, test_y, test_qids, _ = pyltr.data.letor.read_dataset(testfile)
#
#     metric = pyltr.metrics.NDCG(k=10)
#
#     test_pred = model.predict(test_X)
#     print('Random ranking:', metric.calc_mean_random(test_qids, test_y))
#     print('Our model:', metric.calc_mean(test_qids, test_y, test_pred))


# train_model()
# test_model()


