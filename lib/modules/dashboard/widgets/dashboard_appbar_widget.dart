import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/dashboard/providers/task_provider.dart';

class DashboardAppbar extends StatefulWidget {
  final Function onClear;
  final Function onTextSearching;
  final String labelName;

  const DashboardAppbar({
    required this.onClear,
    required this.onTextSearching,
    required this.labelName,
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardAppbar> createState() => _DashboardAppbarState();
}

class _DashboardAppbarState extends State<DashboardAppbar> {
  late bool _isSearchAppbar = false;
  late bool _isClear = false;
  final _focusNodeSearchStories = FocusNode();
  final _searchQueryTextEditingController = TextEditingController();
  late TaskProvider _taskProvider;

  @override
  void initState() {
    _searchQueryTextEditingController.addListener(() {
      if (_searchQueryTextEditingController.text.isNotEmpty) {
        _isClear = true;
      } else {
        _isClear = false;
      }
      setState(() {});
      widget.onTextSearching(_searchQueryTextEditingController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNodeSearchStories.dispose();
    _searchQueryTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return _isSearchAppbar == false ? _getDefaultAppbar() : _getSearchAppbar();
  }

  Widget _getDefaultAppbar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Dashboard",
      ),
      actions: [
        Consumer<TaskProvider>(
          builder: (ctx, _, child) => _taskProvider.isLoading == true
              ? const SizedBox()
              : _taskProvider.tempTaskList.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        _isSearchAppbar = true;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
        ),
      ],
    );
  }

  Widget _getSearchAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          widget.onClear();
          _searchQueryTextEditingController.text = "";
          FocusScope.of(context).requestFocus(_focusNodeSearchStories);
          _isSearchAppbar = false;
          setState(() {});
        },
      ),
      title: TextField(
        autofocus: true,
        controller: _searchQueryTextEditingController,
        style: const TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
        ),
        focusNode: _focusNodeSearchStories,
        cursorColor: Colors.white,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: widget.labelName,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Colors.white70,
            letterSpacing: 1.5,
          ),
        ),
      ),
      actions: [
        _isClear == true
            ? IconButton(
                onPressed: () {
                  widget.onClear();
                  _searchQueryTextEditingController.text = "";
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
