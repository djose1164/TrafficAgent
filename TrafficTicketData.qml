import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "database.js" as Database

QtObject {
    id: root
    readonly property ListModel model: ListModel{
        Component.onCompleted: {
            Database.init();
            append(Database.getAll());
        }
    }

    function addTrafficTicket(ticket: var): void {
        const rowId = parseInt(Database.insert(ticket));
        const addedExp = Object.assign(ticket, {rowId});
        model.append(addedExp);
        print("Experiece with rowId: "+rowId+" added successfully");
    }

    function deleteAll() {
        try {
            forEachFile(file => fileUtils.remove(file));
            Database.deleteAll();
            model.clear();
        } catch(e) {
            print("Failed to delete all: " + e);
        }
    }

    function forEachFile(func): bool {
        for (let i = 0; i < model.count; ++i) {
            const paths = [model.get(i).audioPath, model.get(i).picPath];
            paths.forEach(function(path) {
                if (path !== "" && !func(path)) {
                    print(`path: ${path}`);
                    //throw "Failed to delete "+path+": "+fileUtils.errorString;
                }
            });
        }
    }
}
